class CreateUserProfilesTable < ActiveRecord::Migration
  def change
    create_prototype_table :user_profiles, :id => false, :partitioned => :weekly, :options => 'DISTSTYLE KEY DISTKEY(user_id)' do |t|
      t.string :user_id, :limit => 40, :encode => :lzo
      # covers over 99% of profiles
      t.string :segment_ids, :limit => 4000, :encode => :lzo
      t.string :states, :limit => 512, :encode => :lzo
      t.string :dmas, :limit => 1024, :encode => :lzo
      t.integer :average_age, :encode => :lzo
      t.column :gender_majority, 'char(1)', :encode => :lzo
    end
  end
end