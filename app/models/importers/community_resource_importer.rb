class Importers::CommunityResourceImporter < Importers::BaseImporter
  def primary_import_klass_name
    "CommunityResource"
  end

  def process_row(row)
    puts "DEBUG::KGW -- processing org #{row["organization_name"]}"
    organization = Organization.joins(:location).includes(:location)
                       .where(name: row["organization_name"])
                       .where(locations: {
                           street_address: row["street"],
                           city: row["city"],
                           zip: row["zip"]
                       }).take

    business_location = LocationType.find_or_create_by(name: "business")

    unless organization
      organization = Organization.create! name: row["organization_name"] do |organization|
        organization.location = Location.create! do |location|
          location.street_address = row["street"]
          location.city = row["city"]
          location.state = row["state"]
          location.zip = row["zip"]
          location.county = row["county"]
          location.location_type = business_location
        end
      end
    end

    # Have to filter resources in memory because mobility prevents the
    # `name` attribute from being persisted to the `community_resources`
    # table. This prevents us from querying CommunityResource records by
    # their name using ActiveRecord.
    resource = organization.community_resources.detect { |resource| resource.name == row["name"] }
    if resource
      # Add breaks after the description so that if we are updating this resource with other row data there are visible
      # gaps between each description entry
      resource.description += "#{row["description"]}\n\n"
      resource.tag_list.add(row["category_name"])

      resource.save

      # Resource exists so there's nothing else to update. Return early and move onto the new row.
      # This assumes nothing else needs to be updated for existing data.
      return
    end

    resource = CommunityResource.create!(
        name: row["name"],
        website_url: row["website_url"],
        facebook_url: row["facebook_url"],
        phone: row["phone"],
        youtube_identifier: row["youtube_identifier"],
        publish_from: row["publish_from"],
        publish_until: row["publish_until"],
        is_created_by_admin: row["is_created_by_admin"],
        is_approved: row["is_approved"],
        description: row["description"],
        organization: organization
    )

    resource.tag_list.add(row["category_name"])

    resource.location = Location.create! do |location|
      location.street_address = row["street"]
      location.city = row["city"]
      location.state = row["state"]
      location.zip = row["zip"]
      location.county = row["county"]
      location.location_type = business_location
    end

    service_location_type = LocationType.find_or_create_by(name: "service_area")
    resource.service_area = ServiceArea.create! do |service_area|
      if row["service_area_name"]
        service_area.name = row["service_area_name"]
      elsif row["service_area_town_names"]
        service_area.name = row["service_area_town_names"]
      elsif row["service_area_counties"]
        service_area.name = row["service_area_counties"]
      else
        service_area.name = row["city"]
      end

      if row["service_area_counties"]
        service_area.service_area_type = "county"
      else
        service_area.service_area_type = "city"
      end

      service_area.organization = resource.organization
      service_area.location = Location.create! do |location|
        location.location_type = service_location_type

        location.city = row["service_area_town_names"] ? row["service_area_town_names"] : row["city"]

        location.state = row["state"]

        location.county = row["service_area_counties"] ? row["service_area_counties"] : row["county"]
      end
    end

    resource.save
  end
end