class StaleIssueMarker
  include Sidekiq::Worker
  sidekiq_options :queue => :miq_bot_glacial, :retry => false

  include SidekiqWorkerMixin

  # If an issue/pr has any of these labels, it will not be marked as stale or closed
  PINNED_LABELS    = ['pinned'].freeze

  STALE_LABEL_NAME = 'stale'.freeze
  STALE_ISSUE_MESSAGE = <<-EOS.freeze
This issue has been automatically marked as stale because it has not been updated for at least 3 months.

If you can still reproduce this issue on the current release or on `master`, please reply with all of the information you have about it in order to keep the issue open.

Thank you for all your contributions!
  EOS
  CLOSABLE_PR_MESSAGE = <<-EOS.freeze
This pull request has been automatically closed because it has not been updated for at least 6 months.

Feel free to reopen this pull request if these changes are still valid.

Thank you for all your contributions!
  EOS

  # Triage logic:
  #
  # - Stale after 3 month of no activity
  #
  def perform
    GithubService.search_issues(*search_args).each do |issue|
      if issue.pull_request?
        close_pr(issue)
      else
        mark_as_stale(issue)
      end
    end
  end

  private

  def search_args
    query  = "is:open archived:false update:<#{stale_date.strftime('%Y-%m-%d')}"
    query << " #{PINNED_LABELS.map { |label| %(-label:"#{label}") }.join(" ")}"
    query << " #{enabled_repo_names.map { |repo| %(repo:"#{repo}") }.join(" ")}"

    [query, {:sort => :updated, :direction => :asc}]
  end

  def stale_date
    @stale_date ||= 3.months.ago
  end

  def validate_repo_has_stale_label(repo)
    unless GithubService.valid_label?(repo, STALE_LABEL_NAME)
      raise "The label #{STALE_LABEL_NAME} does not exist on #{repo}"
    end
  end

  def mark_as_stale(issue)
    return if issue.labels.include?(STALE_LABEL_NAME)

    validate_repo_has_stale_label(issue.fq_repo_name)

    logger.info("[#{Time.now.utc}] - Marking issue #{issue.fq_repo_name}##{issue.number} as stale")
    issue.add_labels([STALE_LABEL_NAME])
    issue.add_comment(STALE_ISSUE_MESSAGE)
  end

  def close_pr(pull_request)
    validate_repo_has_stale_label(pull_request.fq_repo_name)
    logger.info("[#{Time.now.utc}] - Closing stale PR #{pull_request.fq_repo_name}##{pull_request.number}")
    GithubService.close_pull_request(pull_request.fq_repo_name, pull_request.number)
    pull_request.add_comment(CLOSABLE_PR_MESSAGE)
  end
end
