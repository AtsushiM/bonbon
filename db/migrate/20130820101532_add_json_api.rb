class AddJsonApi < ActiveRecord::Migration
  def change
      add_column :apis, :result_json, :text
  end
end
