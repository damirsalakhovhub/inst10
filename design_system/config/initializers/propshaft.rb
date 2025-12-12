# In development, add timestamp to CSS URLs to bust browser cache
# This ensures SCSS token changes are immediately visible

if Rails.env.development?
  # Simply disable asset digest in development
  Rails.application.config.assets.digest = false
end
