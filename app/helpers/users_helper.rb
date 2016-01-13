module UsersHelper
  def gravatar_for(user,w=80)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    #gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    gravatar_url = "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{w}&d=retro"
    image_tag(gravatar_url, alt: user.name, class: "gravatar img-circle")
  end
end
