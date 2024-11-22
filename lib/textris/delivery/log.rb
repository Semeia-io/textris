module Textris
  module Delivery
    class Log < Textris::Delivery::Base
      def deliver(to)
        log :debug, "Sent text to #{Phony.format(to)}"
        log :debug, "Texter: #{message.texter || 'UnknownTexter'}" + "#" +
          "#{message.action || 'unknown_action'}"
        log :debug, "Date: #{Time.now}"
        log :debug, "From: #{message.from || message.twilio_messaging_service_sid || 'unknown'}"
        log :debug, "To: #{message.to.map { |i| Phony.format(to) }.join(', ')}"
        log :debug, "Content: #{message.content}"
        (message.media_urls || []).each_with_index do |media_url, index|
          logged_message = index == 0 ? "Media URLs: " : "            "
          logged_message << media_url
          log :debug, logged_message
        end
      end

      private

      def log(level, message)
        Rails.logger.send(level, message)
      end
    end
  end
end
