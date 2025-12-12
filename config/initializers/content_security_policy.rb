# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.object_src  :none
    policy.base_uri    :self

    policy.img_src     :self, :data
    policy.font_src    :self, :data
    policy.style_src   :self
    policy.script_src  :self

    report_uri = ENV["CONTENT_SECURITY_POLICY_REPORT_URI"]
    policy.report_uri report_uri if report_uri.present?

    if Rails.env.development?
      # Relax policy in development for convenience
      policy.connect_src :self, :https, "http://localhost:3035", "ws://localhost:3035", "ws://127.0.0.1:3000"
      policy.style_src   :self, :unsafe_inline
      policy.script_src  :self, :unsafe_inline
    end
  end

  # Nonces for inline scripts/styles (importmap/turbo)
  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src style-src]

  # Enable report-only mode to test policy without enforcing
  # config.content_security_policy_report_only = true
end
