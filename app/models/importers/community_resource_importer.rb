class Importers::CommunityResourceImporter < Importers::BaseImporter
  def primary_import_klass_name
    "CommunityResource"
  end

  def process_row(row)
    puts "Pair programming @ RFG!!!"
    comm_resource = CommunityResource.create! name: row["name"], website_url: row["website_url"], facebook_url: row["facebook_url"], phone: row["phone"], description: row["description"]

    comm_resource.organization = Organization.create! name: row["organization_name"]
    # comm_resource.location = Location.create! street_address: row["street"]
    comm_resource.save
  end
end