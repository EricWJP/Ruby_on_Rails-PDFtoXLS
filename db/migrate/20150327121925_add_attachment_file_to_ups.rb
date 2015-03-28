class AddAttachmentFileToUps < ActiveRecord::Migration
  def self.up
    change_table :ups do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :ups, :file
  end
end
