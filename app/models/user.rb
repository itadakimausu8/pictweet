class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
# ↑ deviseモジュールの設定を行える。
# それぞれの詳細はhttp://qiita.com/cigalecigales/items/73d7bd7ec59a001ccd74を参照。
  has_many :tweets
#アソシエーションを定義するために使う。一(Userモデル)対多(Tweetモデル)
#一対多の関係において自分のモデルが「一」の条件に当てはまるときに使用。
#記述することでuser.tweetsの記述を可能にする。
  has_many :comments
#アソシエーションを定義するために使う。一(Userモデル)対多(Commentモデル)
#一対多の関係において自分のモデルが「一」の条件に当てはまるときに使用。
#記述することでuser.commentsの記述を可能にする。
  validates :nickname, presence: true, length: { maximum: 6 }
#validatesメソッド：モデルクラスによって作られたインスタンスの検証を行うことができる。
# ↑ の場合nicknameカラムが「存在している」かつ「文字列の長さが６以内に収まる」ときそのインスタンスが存在することを認める。
end
