class DiscordMessageSender
  def send_message(message)
    formatted_message = "**__NOUVEAU MESSAGE STRAIGHT FROM ZE WEBSITE__:**" \
                        "\n- Nom: #{message.name}" \
                        "\n- Email: #{message.email}" \
                        "\n- Tel: #{message.phone}" \
                        "\n- Organisation: #{message.organisation}" \
                        "\n- Message: #{message.body}"

    response = Faraday.post("https://discord.com/api/v10/channels/#{Rails.application.credentials.discord_channel_id}/messages") do |req|
      req.headers["Authorization"] = "Bot #{Rails.application.credentials.discord_bot_token}"
      req.headers["Content-Type"] = "application/json"
      req.body = { content: formatted_message }.to_json
    end

    # TODO: handle errors
  end
end
