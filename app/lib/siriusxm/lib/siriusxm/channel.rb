require 'json'
require 'net/http'

module Siriusxm
  module Channel
    CHANNEL_LIST_URL = 'https://www.siriusxm.com/channelfeed/SXM_SIR_AUD_ALLACCESS'.freeze
    CHANNEL_DETAIL_URL = 'https://www.siriusxm.com/api/mountain/'.freeze

    class << self
      ##
      # Returns the list of channels available
      #
      def list
        call_api(CHANNEL_LIST_URL)['channels']
      end

      ##
      # Given a channel contentId, returns a hash of channel information, including the currently playing content
      #
      def now_playing(content_id)
        content_id = content_id.join(',') if content_id.is_a? Array
        call_api("#{CHANNEL_DETAIL_URL}#{content_id}")['channels']
      end

      private

      def call_api(url)
        begin
          JSON.parse(Net::HTTP.get_response(URI(url)).body)
        rescue => e
          raise e.message
        end
      end
    end
  end
end

# if data.is_a?(Array)
#   data.map { |item| item.deep_transform_keys!(&:underscore) }
# else
#   data.deep_transform_keys!(&:underscore)
# end
