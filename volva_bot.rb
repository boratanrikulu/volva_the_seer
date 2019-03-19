require './volva'
require 'telegram/bot'
require 'dotenv/load'

class VolvaBot

  def initialize(key)
    @token = key

    telegram_api
  end

  private

  def telegram_api
    # Listens all messages these come from the user.
    # Then sends the string to Volva_Bot.
    Telegram::Bot::Client.run(@token) do |bot|
      
      bot.listen do |message|
        volva =  Volva.new(message.text)
        chat = { id: message.chat.id }

        case message.text
        when '/start', '/help', 'help'
          bot.api.send_message(chat_id: chat[:id], text: volva.help)
        else
          bot.api.send_message(chat_id: chat[:id], text: volva.start)
        end
      end
    end
  end
end

# API_KEY is in .env file
volva_bot = VolvaBot.new(ENV['API_KEY'])
