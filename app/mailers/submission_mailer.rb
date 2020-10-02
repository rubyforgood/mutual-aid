require "#{Rails.root}/app/helpers/application_helper.rb"
include ApplicationHelper  # TODO: better way to solve this?

# TODO: could do with specs
class SubmissionMailer < ApplicationMailer

  def new_submission_confirmation_email(submission, system_setting=nil)
    @submission = submission

    current_organization = Organization.current_organization
    @organization_name = current_organization.name
    @system_setting = system_setting || SystemSetting.first

    @form_name = @submission.form_name
    if @form_name.downcase.include?("ask")
      @form_contact = Organization.current_organization.ask_form_contact
    elsif @form_name.downcase.include?("offer")
      @form_contact = Organization.current_organization.offer_form_contact
    elsif @form_name.downcase.include?("community_resource")
      @form_contact = Organization.current_organization.community_resources_contact
    end

    @person = @submission.person
    @locale = @person.preferred_locale || 'en'

    @system_settings = SystemSetting.current_settings

    system_email = ENV["SYSTEM_EMAIL"]
    smtp_from_email = ENV["SMTP_FROM_EMAIL"]
    contact_email = @form_contact&.person&.email || "#{smtp_from_email}"
    contact_name =  @form_contact&.person&.name || @form_contact&.name || contact_email
    contact_email_with_name = %("#{contact_name} (#{Organization.current_organization.name})" <#{contact_email}>)
    bcc_emails = [contact_email, smtp_from_email, system_email].uniq.join("; ")

    @subject =  "#{ENV["SYSTEM_APP_NAME"]} confirmation (" + @person.updated_at.to_date.to_s + ")"

    mail(to: @person.email,
         from: contact_email_with_name,
         bcc: bcc_emails,
         reply_to: contact_email_with_name.to_s + ", " + system_email.to_s,
         subject: @subject) do |format|
      format.html { render template_path: 'submission_mailer',
                           template_name: 'new_submission_confirmation_email' }
    end
  end

end
