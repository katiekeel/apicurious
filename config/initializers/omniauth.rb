Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, "f81faeafc8a1e085df85", "44b976fed012497ecf865ad20453900d7855da53"
end
