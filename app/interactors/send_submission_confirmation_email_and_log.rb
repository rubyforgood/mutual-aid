class SendSubmissionConfirmationEmailAndLog < BaseInteractor
  integer :submission_id
  integer :current_user_id

  def execute
    merging_errors(in_transaction: true) do
      submission_record = Submission.find(submission_id)
      current_user_record = User.find(current_user_id)

      Rails.logger.info "----------------SEND EMAIL CONFIRMATION"
      # send the email
      autoemail = SubmissionMailer.new_submission_confirmation_email(submission_record, @system_setting)
      delivery_status = deliver_now_with_error_handling(autoemail, "new_submission_confirmation_email")

      # store email that was sent
      CommunicationLog.log_submission_email(autoemail, delivery_status, submission_record, CommunicationLog::AUTO_DELIVERY_CHANNEL, current_user_record)

      submission_record
    end
  end
end
