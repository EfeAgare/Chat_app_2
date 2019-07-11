module MessageHelper
  def fetch_all_messages_redis
    messages = $redis.get('messages')  rescue nil # This line requests redis-server to accepts any value associate with messages key
    if !messages.nil? # this condition will executes if any messages not available on redis server
       messages = Message.where('friend_message_id is null')
      $redis.set('messages', messages)
      $redis.expire('messages', 1.hour.to_i)
    end
    messages
  end

  def fetch_specific_messages_redis
    messages = $redis.get('messages') rescue nil  # This line requests redis-server to accepts any value associate with messages key
    if !messages.nil? # this condition will executes if any messages not available on redis server
      messages = Message.where("user_message_id = ? AND friend_message_id = ? OR
        user_message_id = ? AND friend_message_id = ? ",
                               session[:user_id], params[:friend_message_id],
                               params[:friend_message_id], session[:user_id])
      $redis.set('messages', messages)
      $redis.expire('messages', 1.hour.to_i)
    end
    messages
  end

  def markdown_to_html(text)
    if text.nil?
      return
    end
    Kramdown::Document.new(text, input: 'GFM').to_html
  end
end
