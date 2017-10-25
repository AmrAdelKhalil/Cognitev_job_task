class CreateStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :statuses do |t|
      t.string :description, :defaut => ""
      t.references :user
      t.timestamps
    end
  end
end
