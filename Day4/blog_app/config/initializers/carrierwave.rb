CarrierWave.configure do |config|
  # Use local storage in development
  config.storage = :file
  
  # Ensure MiniMagick is our processor
  config.enable_processing = true
  
  # Set the MiniMagick processor options
  if defined?(CarrierWave::MiniMagick)
    config.mini_magick_cli_options = {
      timeout: 10 # Set a timeout for image processing (in seconds)
    }
  end

  # For testing, disable processing
  if Rails.env.test? || Rails.env.cucumber?
    config.enable_processing = false
  end

  # Add custom error messages
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false
end
