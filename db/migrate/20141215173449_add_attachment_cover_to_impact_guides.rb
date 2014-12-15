class AddAttachmentCoverToImpactGuides < ActiveRecord::Migration
  def self.up
    change_table :impact_guides do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :impact_guides, :cover
  end
end
