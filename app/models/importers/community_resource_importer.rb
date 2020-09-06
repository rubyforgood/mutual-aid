class Importers::CommunityResourceImporter < Importers::BaseImporter
  def primary_import_klass_name
    "CommunityResource"
  end

  def process_row(row)
    puts "Pair programming @ RFG!!!"
    CommunityResource.create! name: row["name"]
  end
end