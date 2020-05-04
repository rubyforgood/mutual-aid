module DeliverNowWithErrorHandling
  extend ActiveSupport::Concern

  def deliver_now_with_error_handling(autoemail, mailer_view_name=nil)
    delivery_status = CommunicationLog::DEFAULT_DELIVERY_STATUS
    begin
      autoemail.deliver_now
    rescue => e
      delivery_status = "FAILED #{e}"
      Rails.logger.info("=============BEGIN ERROR/PROBLEM WITH EMAIL DELIVERY: #{mailer_view_name}=================")
      Rails.logger.info("============= #{e} =================")
      Rails.logger.info("=============END ERROR/PROBLEM WITH EMAIL DELIVERY: #{mailer_view_name}=================")
    end
    delivery_status
  end
end