class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string     :name
    #t.型          #:カラム名
      t.text       :text
      t.text       :image
      t.timestamps
    end
  end
end
