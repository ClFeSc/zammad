# Copyright (C) 2012-2022 Zammad Foundation, https://zammad-foundation.org/

class Scheduler < ApplicationModel
  include ChecksHtmlSanitized
  include HasTimeplan

  sanitized_html :note

  scope :failed_jobs, -> { where(status: 'error', active: false) }

  # This function restarts failed jobs to retry them
  #
  # @example
  #   Scheduler.restart_failed_jobs
  #
  # return [true]
  def self.restart_failed_jobs
    failed_jobs.each do |job|
      job.update!(active: true)
    end

    true
  end
end
