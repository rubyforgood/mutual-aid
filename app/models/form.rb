class Form < ApplicationRecord
  belongs_to :organization
  has_many :questions, class_name: 'FormQuestion'
end

# == Schema Information
#
# Table name: forms
#
#  id                     :bigint           not null, primary key
#  contribution_type_name :string
#  display_categories     :boolean
#  footer_html            :string
#  header_html            :string
#  name                   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  organization_id        :bigint           not null
#
# Indexes
#
#  index_forms_on_organization_id  (organization_id)
#
# Foreign Keys
#
#  fk_rails_...  (organization_id => organizations.id)
#
