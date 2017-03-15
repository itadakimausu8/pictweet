class Tweet < ActiveRecord::Base
#ActiveRecord::BaseによってTweetがデータベースにアクセスできる
#・all,new,save,find,createメソッド(rails)を使用可能にする
#これらがSQL言語に変換することで代わりにDBを動かしている
  belongs_to :user
  has_many :comments
end
