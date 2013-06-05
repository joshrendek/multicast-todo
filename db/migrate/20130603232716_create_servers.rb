class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :ip
      t.integer :port

      t.timestamps
    end
  end
end
