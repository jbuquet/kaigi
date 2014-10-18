require 'uri'

module RetrospectivesHelper

  def retrospective_link(retrospective)
    URI.join(root_url,retrospective_path(retrospective.public_key))
  end
end