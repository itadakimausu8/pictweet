class Tweet < ActiveRecord::Base
#ActiveRecord::BaseによってTweetがデータベースにアクセスできる
#・all,new,save,find,createメソッド(rails)を使用可能にする
#これらがSQL言語に変換することで代わりにDBを動かしている
  belongs_to :user
#アソシエーションを定義するために使う。一(Userモデル)対多(Tweetモデル)
#一対多の関係において自分のモデルが「多」の条件に当てはまるときに使用。
#記述することでtweets.userの記述を可能にする。
  has_many :comments
#アソシエーションを定義するために使う。一(Tweetモデル)対多(Commentモデル)
#一対多の関係において自分のモデルが「一」の条件に当てはまるときに使用。
#記述することでtweet.commentsの記述を可能にする。
end
