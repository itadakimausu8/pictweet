class Comment < ActiveRecord::Base
  belongs_to :tweet
  #アソシエーションを定義するために使う。一(Tweetモデル)対多(Commentsモデル)
  #一対多の関係において自分のモデルが「多」の条件に当てはまるときに使用。
  #記述することでcomments.tweetの記述を可能にする。
  belongs_to :user
  #アソシエーションを定義するために使う。一(Userモデル)対多(Commentsモデル)
  #一対多の関係において自分のモデルが「多」の条件に当てはまるときに使用。
  #記述することでcomments.userの記述を可能にする。
end
