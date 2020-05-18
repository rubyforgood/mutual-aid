class SaveSubmission < BaseInteractor
  record :listing
  integer :current_user_id

  def execute
    merging_errors(in_transaction: true) do
      listing_record = compose SaveListing, listing
      current_user_record = User.find(current_user_id)

      where_params = {
          person: listing_record.person,
          service_area: listing_record.service_area,
          form_name: "#{listing_record.type.downcase}_form",
          # privacy_level_requested: ?, # TODO - implement privacy_level_options
          created_at: listing_record.created_at
      }
      create_params = { body: listing_record.attributes.merge(current_user_id: current_user_id) }
      submission = Submission.where(where_params).first
      unless submission
        submission = Submission.create!(where_params.merge create_params)
      end

      SendSubmissionConfirmationEmailAndLog.run(submission&.id, current_user_id)
    end
  end
end
