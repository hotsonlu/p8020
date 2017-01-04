class AddSummaryAndWriterIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :summary, :text
    add_column :posts, :writer_id, :integer
  end
end
