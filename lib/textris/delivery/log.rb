module Textris
  module Delivery
    class Log < Textris::Delivery::Base
      def deliver(to)
        Rails.logger.debug("Textris") { "Sent text to #{Phony.format(to)}" }
        Rails
          .logger
          .info("Textris") do
            "Texter: #{message.texter || "UnknownTexter"}" + "#" +
              "#{message.action || "unknown_action"}"
          end
        Rails.logger.info("Textris") { "Date: #{Time.now}" }
        Rails
          .logger
          .info("Textris") do
            "From: #{message.from || message.twilio_messaging_service_sid || "unknown"}"
          end
        Rails
          .logger
          .debug("Textris") do
            "To: #{message.to.map { |i| Phony.format(to) }.join(", ")}"
          end
        Rails.logger.debug("Textris") { "Content: #{message.content}" }
        (message.media_urls || []).each_with_index do |media_url, index|
          logged_message = index == 0 ? "Media URLs: " : "            "
          logged_message << media_url
          Rails.logger.debug("Textris") { logged_message }
        end
      end
    end
  end
end
