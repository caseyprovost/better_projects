IntertiaProjects::Application.config.session_store(
  :cookie_store,
  {
    key: "_better_projects_session",
    domain: :all, # :all defaults to da tld length of 1, '.web' has length of 1
    tld_length: 2 # Top Level Domain (tld) length -> '*.myapp.web' has a length of 2
  }
)
