 class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	#Indicate that table will have a title
    	t.string:title
    end
  end
end
