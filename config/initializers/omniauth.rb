OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '90934662224-evaulio5qih2tbtpea3982795884oo6m.apps.googleusercontent.com', 'SbMOZxCBKA8F5On1Qgv-4m9k' 
  
end