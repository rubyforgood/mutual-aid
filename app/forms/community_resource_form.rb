# frozen_string_literal: true

class CommunityResourceForm < BaseForm
  string :description
  string :name
  date   :publish_from

  hash :organization_attributes do
    string :id, default: nil
    string :name
  end

  with_options default: nil do
    integer :id
    string  :facebook_url
    string  :location_id
    string  :phone
    date    :publish_until
    string  :website_url
    string  :youtube_identifier
    array   :service_area_ids
    array   :tag_list

    # todo now: rename
    hash :location, strip: false
  end

  def execute
    CommunityResource.find_or_new(id).tap do |community_resource|
      community_resource.attributes = given_inputs.merge(
        location: LocationForm.build(location),
      )
    end
  end
end
