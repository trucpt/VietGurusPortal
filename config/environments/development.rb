Rails.application.configure do
  # S3
  ENV['AWS_ACCESS_KEY_ID']     = 'AKIAJLUQ4PLG6D77BAJQ'
  ENV['AWS_SECRET_ACCESS_KEY'] = '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'
  ENV['AWS_REGION']            = 'ap-southeast-1'
  ENV['AWS_S3_BUCKET']         = 'vietgurus-nightly'
  ENV['AWS_S3_AVATAR_DIR']     = 'avatars'

  # AIS
  ENV['EXACT_AIS_API_TOKEN'] = '1ad4a03e-5b28-4b42-a84a-ddf5ef12fe1a'

  # WNI
  ENV['WNI_API_UID']         = 'scs'
  ENV['WNI_API_PASSWORD']    = 'LCiouXk'

  # Google Calendar API
  ENV['GCAL_CLIENT_ID'] = '96835738130-pnjvdcu8jb4teh62ge5bfp4mhe6cq10a.apps.googleusercontent.com'
  ENV['GCAL_CLIENT_SECRET'] = 'lokVi_ZSMi-kWhBqVElxRwXq'
  ENV['GCAL_CALENDAR_ID'] = 'vq6tkrsdc39fae7u4r7a1oo710@group.calendar.google.com'
  ENV['GCAL_CALLBACK_URL'] = 'http://localhost:3000/oauth2callback'

  # Imgur
  ENV['IMGUR_ID']       = 'd17be6dd29b4f8d'
  ENV['IMGUR_SECRET']   = 'abdd220df783817b792e184a2add206fe645d570'
  ENV['IMGUR_REFRESH']  = '2711f79c2e1d5b7753d5b74b7594d439faf3d8a8'
  ENV['IMGUR_TOKEN']    = 'dbac55f90118b3b8dc420e16286071600af70167'
  ENV['IMGUR_ALBUM_ID'] = 'vtB6K'

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # Asset digests allow you to set far-future HTTP expiration dates on all assets,
  # yet still be able to expire them through the digest params.
  config.assets.digest = true

  # Adds additional error checking when serving assets at runtime.
  # Checks for improperly declared sprockets dependencies.
  # Raises helpful error messages.
  config.assets.raise_runtime_errors = true

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true

  config.paperclip_defaults = {
      storage: :s3,
      s3_credentials: {
          bucket: ENV.fetch('AWS_S3_BUCKET'),
          access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
          secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
          s3_region: ENV.fetch('AWS_REGION'),
      }
  }
end
