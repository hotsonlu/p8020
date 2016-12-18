Rails.application.config.middleware.use OmniAuth::Builder do
  provider :wechat, Figaro.env.OMNIAUTH_WECHAT_KEY, Figaro.env.OMNIAUTH_WECHAT_SECRET,
    provider_ignores_state: true
end
