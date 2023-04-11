class CreateSolidusAuthorizenetSources < ActiveRecord::Migration[7.0]
  def change
    create_table :solidus_authorizenet_sources do |t|
      t.references :payment_method, index: true
      t.integer :user_id, index: true
      t.boolean :default, default: false, null: false
      t.string :name
      t.string :month
      t.string :year
      t.integer :cc_type
      t.string :number
      t.integer :verification_value
      t.string :last_digits
      t.integer :address_id

      t.timestamps null: false
    end
  end
end
