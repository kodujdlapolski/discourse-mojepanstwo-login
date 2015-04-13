# name: MojePanstwo login
# about: Authenticate with discourse with MojePanstwo.pl.
# version: 0.3.1
# authors: Krzysztof Madejski, Erick Guan
# url: https://github.com/kodujdlapolski/discourse-mojepanstwo-login

gem 'omniauth-mojepanstwo-oauth2'

class MojepanstwoAuthenticator < ::Auth::Authenticator

  def name
    'mojepanstwo'
  end

  def after_authenticate(auth_token)
    result = Auth::Result.new

    data = auth_token[:info]
    email = auth_token[:extra][:email]
    raw_info = auth_token[:extra][:raw_info]
#	Trusing email, not using uid
#    weibo_uid = auth_token[:uid]

#    current_info = ::PluginStore.get('mojepanstwo', "mojepanstwo_uid_#{weibo_uid}")

#    result.user =
#      if current_info
#        User.where(id: current_info[:user_id]).first
#      end

    result.name = data['name']
    #result.username = data['name']
    result.email = email
    result.extra_data = { 
#	weibo_uid: weibo_uid, 
	raw_info: raw_info 
    }

    result
  end

#  def after_create_account(user, auth)
#    weibo_uid = auth[:extra_data][:uid]
#    ::PluginStore.set('mojepanstwo', "weibo_uid_#{weibo_uid}", {user_id: user.id})
#  end

  def register_middleware(omniauth)
    omniauth.provider :mojepanstwo, :setup => lambda { |env|
      strategy = env['omniauth.strategy']
      strategy.options[:client_id] = SiteSetting.mojepanstwo_client_id
      strategy.options[:client_secret] = SiteSetting.mojepanstwo_client_secret
    }
  end
end

auth_provider :frame_width => 920,
              :frame_height => 800,
              :authenticator => MojepanstwoAuthenticator.new,
              :background_color => 'rgb(230, 22, 45)'

register_css <<CSS

.btn-social.mojepanstwo:before {
  font-family: FontAwesome;
  content: "\\f18a";
}

CSS
