require "#{Rails.root}/app/helpers/application_helper.rb"
include ApplicationHelper

class SubmissionMailer < ApplicationMailer

  def new_submission_confirmation_email(submission)
    @submission = submission

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

    system_email = "#{ENV["SYSTEM_EMAIL"]}"
    email_with_name = %("#{system_email}" <#{system_email}>)

    @subject =  "#{ENV["SYSTEM_APP_NAME"]} confirmation (" + @person.updated_at.to_date.to_s + ")"

    mail(to: @person.email,
         from: email_with_name,
         bcc: system_email,
         reply_to: email_with_name.to_s + ", " + system_email.to_s,
         subject: @subject) do |format|
      format.html { render template_path: 'submission_mailer',
                           template_name: 'new_submission_confirmation_email' }
    end
  end
end
