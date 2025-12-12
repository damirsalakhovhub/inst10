# Comprehensive API protection with rack-attack
# Protects against DDoS, brute force, and aggressive clients

class Rack::Attack
  # Safelist health checks and local requests
  safelist("allow-health") do |req|
    req.path == "/up"
  end

  safelist("allow-localhost") do |req|
    req.ip == "127.0.0.1" || req.ip == "::1"
  end

  # Global request throttle per IP
  # Prevents single IP from overwhelming the app
  throttle("req/ip", limit: 300, period: 5.minutes) do |req|
    req.ip unless req.path == "/up"
  end

  # Throttle login attempts by IP
  throttle("logins/ip", limit: 10, period: 1.minute) do |req|
    req.ip if req.post? && req.path == "/users/sign_in"
  end

  # Throttle login attempts by email
  throttle("logins/email", limit: 5, period: 1.minute) do |req|
    if req.post? && req.path == "/users/sign_in"
      req.params.dig("user", "email").to_s.downcase.presence
    end
  end

  # Throttle signup attempts
  throttle("signups/ip", limit: 5, period: 1.hour) do |req|
    req.ip if req.post? && req.path == "/users"
  end

  # Throttle password reset requests
  throttle("password_resets/ip", limit: 5, period: 1.hour) do |req|
    req.ip if req.post? && req.path == "/users/password"
  end

  # Throttle password reset by email
  throttle("password_resets/email", limit: 3, period: 1.hour) do |req|
    if req.post? && req.path == "/users/password"
      req.params.dig("user", "email").to_s.downcase.presence
    end
  end

  # Throttle admin panel access
  throttle("admin/ip", limit: 100, period: 1.minute) do |req|
    req.ip if req.path.start_with?("/admin") || req.path.start_with?("/avo")
  end

  # Block suspicious requests
  blocklist("block-scrapers") do |req|
    # Block requests with suspicious user agents
    req.user_agent.present? && req.user_agent.match?(/scraper|bot|crawler|spider/i) &&
      !req.user_agent.match?(/googlebot|bingbot/i)
  end

  # Custom response for throttled requests
  self.throttled_responder = lambda do |request|
    match_data = request.env["rack.attack.match_data"]
    now = match_data[:epoch_time]

    headers = {
      "RateLimit-Limit" => match_data[:limit].to_s,
      "RateLimit-Remaining" => "0",
      "RateLimit-Reset" => (now + match_data[:period]).to_s,
      "Content-Type" => "application/json"
    }

    [ 429, headers, [ { error: "Rate limit exceeded. Try again later." }.to_json ] ]
  end
end
