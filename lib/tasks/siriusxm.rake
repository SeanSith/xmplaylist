namespace :siriusxm do
  desc 'Load Channel List from SiriusXM.com'
  task load_channels: :environment do
    channels = Siriusxm::Channel.list.map do |channel|
      { content_id: channel['contentId'], detail: channel }
    end
    Channel.upsert_all(channels, unique_by: :content_id)
  end

  desc 'Updates channel attributes based on JSON already stored in the database'
  task update_channel_attributes: :environment do
    Channel.all.each do |channel|
      json = JSON.parse(channel[:channel_json])
      channel[:display_name] = json.detail['displayName']
      channel.save
    end
  end
end
