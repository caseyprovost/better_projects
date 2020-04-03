class CreateBuckets < ActiveRecord::Migration[6.0]
  def change
    create_table :buckets do |t|
      t.references :bucketable, polymorphic: true, null: false, index: true
      t.references :account, null: false, index: true, foreign_key: true

      t.timestamps
    end
  end
end
