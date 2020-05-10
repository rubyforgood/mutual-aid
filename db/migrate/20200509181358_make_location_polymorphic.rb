class MakeLocationPolymorphic < ActiveRecord::Migration[6.0]
  def change
    add_reference :locations, :locationable, polymorphic: true, null: false, index: true
  end
end
