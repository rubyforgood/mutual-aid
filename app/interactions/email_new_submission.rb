class EmailNewSubmission < ActiveInteraction::Base
  object :submission
  object :user

  def execute
    email = SubmissionMailer.new_submission_confirmation_email submission
    delivery_status = deliver_now email, 'new_submission_confirmation_email'
    CommunicationLog.log_email email, delivery_status, submission.person, nil, user
  end

  private

    # TODO: extract this, consolidate with deliver_now_with_error_handling.rb
    def deliver_now email, mailer_name
      email.deliver_now
      return CommunicationLog::DEFAULT_DELIVERY_STATUS

    rescue Net::SMTPError => e # TODO: what other errors do we need to allow/log
      Rails.logger.error "Error encountered delivering #{mailer_name} email"
      Rails.logger.error e
      return 'undeliverable'
    end
end
