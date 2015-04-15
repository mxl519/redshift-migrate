class CreateUserProfileSegments < ActiveRecord::Migration
  def change
    create_prototype_table :user_profile_segments, :id => false, :partitioned => :weekly,
                           :options => 'DISTSTYLE KEY DISTKEY(user_id)' do |t|
      t.string :user_id, :limit => 40, :encode => :lzo
      t.integer :segment_id, :encode => :delta32k
    end
  end
end