# SecureHeaders::Configuration.default
SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      lax: true # mark all cookies as SameSite=lax
    }
  }
  # Add "; preload" and submit the site to hstspreload.org for best protection.
  config.hsts = "max-age=#{1.week.to_i}"
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = %w(origin-when-cross-origin strict-origin-when-cross-origin)
  config.csp = {
    # # "meta" values. these will shape the header, but the values are not included in the header.
    preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    disable_nonce_backwards_compatibility: false, # default: false. If false, `unsafe-inline` will be added automatically when using nonces. If true, it won't. See #403 for why you'd want this.
    
    # # directive values: these values will directly translate into source directives
    #default_src: %w('none'),
     default_src: %W('self'),

    base_uri: %w('self'),
    block_all_mixed_content: true, # see http://www.w3.org/TR/mixed-content/
    child_src: %w('self'), # if child-src isn't supported, the value for frame-src will be set.
    # connect_src: %w('self'),
    font_src: %w('self'),
    form_action: %w('self'),
    frame_ancestors: %w('none'),
    img_src: %w('self' data:),
    manifest_src: %w('self'),
    media_src: %w('none'),
    object_src: %w('self'),
    # # sandbox: true, # true and [] will set a maximally restrictive setting
    # plugin_types: %w(application/x-shockwave-flash),

    #script_src: %w('self' 'unsafe-inline'),
    script_src: %w('self' 'unsafe-inline'),
    style_src: %w('self' 'unsafe-inline'),
    worker_src: %w('self')
    # upgrade_insecure_requests: true, # see https://www.w3.org/TR/upgrade-insecure-requests/
  }
  # This is available only from 3.5.0; use the `report_only: true` setting for 3.4.1 and below.
  # config.csp_report_only = config.csp.merge({
  #   img_src: %w(somewhereelse.com),
  #   report_uri: %w(https://report-uri.io/example-csp-report-only)
  # })
end


# SecureHeaders::Configuration.default do |config|
#   config.csp = {
#       script_src: %w(assets-cdn.github.com),
#       img_src: %w('self' *.wp.com *.gravatar.com collector.githubapp.com www.google-analytics.com data: identicons.github.com assets-cdn.github.com *.githubusercontent.com),
#       frame_ancestors: %w('none'),
#       default_src: %w('none'),
#       frame_src: %w(render.githubusercontent.com),
#       object_src: %w(assets-cdn.github.com),
#       style_src: %w('unsafe-inline' assets-cdn.github.com),
#       connect_src: %w(github-cloud.s3.amazonaws.com status.github.com 'self' www.google-analytics.com wss://live.github.com uploads.github.com api.github.com),
#       plugin_types: %w(application/x-shockwave-flash),
#       child_src: %w(render.githubusercontent.com),
#       media_src: %w('none'),
#       font_src: %w(assets-cdn.github.com),
#       block_all_mixed_content: %w(),
#       form_action: %w(github.com gist.github.com 'self'),
#       base_uri: %w('self')
#   }
# end