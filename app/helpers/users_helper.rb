module UsersHelper
  # Returns an avatar for the given user.
  def avatar_for(user, options = { size: 80 })
    gravatar_id  = Digest::MD5::hexdigest(user.email.downcase)
    size         = options[:size]
    robohash_url = "http://robohash.org/#{gravatar_id}?gravatar=hashed&size=#{size}x#{size}&bgset=bg3"
    image_tag(robohash_url, alt: user.name, class: 'gravatar')
  end
end
