module MessageHelper
  def fetch_all_messages_redis
    messages = Marshal.load($redis.get('messages'))  rescue nil # This line requests redis-server to accepts any value associate with messages key
    if messages.nil? # this condition will executes if any messages not available on redis server
      messages = Message.where('friend_message_id is null').includes(:user_message, :friend_message)
      $redis.set('messages', Marshal.dump(messages))
      $redis.expire('messages', 1.hour.to_i)
    end
    messages
  end

  def fetch_specific_messages_redis
    friend_messages = Marshal.load($redis.get('friend_messages')) rescue nil  # This line requests redis-server to accepts any value associate with messages key
    if friend_messages.nil? # this condition will executes if any messages not available on redis server
      friend_messages = Message.where("user_message_id = ? AND friend_message_id = ? OR
        user_message_id = ? AND friend_message_id = ? ",
                               session[:user_id], params[:friend_message_id],
                               params[:friend_message_id], session[:user_id]).includes(:user_message, :friend_message)
      $redis.set('friend_messages', Marshal.dump(friend_messages))
      $redis.expire('friend_messages', 1.hour.to_i)
    end
    friend_messages
  end

  def markdown_to_html(text)
    if text.nil?
      return
    end
    Kramdown::Document.new(text, input: 'GFM').to_html
  end
end
