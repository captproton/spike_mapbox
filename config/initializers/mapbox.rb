# ENV["mapbox"] = Rails.application.credentials.dig(:mapbox, :public_token)
Mapkick.options[:access_token] = Rails.application.credentials.dig(:mapbox, :public_token)