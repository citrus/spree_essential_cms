class CreateContents < ActiveRecord::Migration
  def self.up
    create_table :contents do |t|
      t.references :page
      t.string     :title
      t.text       :body     
      t.string     :link
      t.string     :link_text
      t.string     :context
      t.boolean    :hide_title, :default => false
            
      t.integer    :position, :default => 999
      
      t.string     :attachment_file_name
      t.string     :attachment_content_type
      t.integer    :attachment_file_size
      t.datetime   :attachment_updated_at
      
      t.timestamps
    end
    
  end

  def self.down
    drop_table :contents
  end
end
