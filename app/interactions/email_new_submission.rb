class EmailNewSubmission < ActiveInteraction::Base
  object :submission
  object :user

  def execute
    email = SubmissionMailer.new_submission_confirmation_email(submission)

    status = Messenger.new(email, 'new_submission_confirmation_email').deliver_now

    CommunicationLog.log_email(
      email: email,
      delivery_status: status,
      person: submission.person,
      initiator: user,
    )
  end
end
