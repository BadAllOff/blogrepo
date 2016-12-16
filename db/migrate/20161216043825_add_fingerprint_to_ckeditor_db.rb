class AddFingerprintToCkeditorDb < ActiveRecord::Migration
  def change
    add_column :ckeditor_assets, :data_fingerprint, :string
    add_index :ckeditor_assets, :type
  end
end
