# name: MojePanstwo login
# about: Authenticate with discourse with MojePanstwo.pl.
# version: 0.3.1
# authors: Krzysztof Madejski, Erick Guan
# url: https://github.com/kodujdlapolski/discourse-mojepanstwo-login

gem 'omniauth-mojepanstwo-oauth2', '0.4.0'
require 'auth/oauth2_authenticator'

class MojepanstwoAuthenticator < ::Auth::OAuth2Authenticator

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
              :authenticator => MojepanstwoAuthenticator.new('mojepanstwo', trusted: true),
              :background_color => 'rgb(230, 22, 45)'

register_css <<CSS

.btn-social.mojepanstwo:before {
}

CSS
