class EmailNewSubmission < ActiveInteraction::Base
  object :submission
  object :user

  def execute
    email = SubmissionMailer.new_submission_confirmation_email submission
    delivery_status = Messenger.new(email, 'new_submission_confirmation_email').deliver_now
    CommunicationLog.log_email email, delivery_status, submission.person, nil, user
  end
end
