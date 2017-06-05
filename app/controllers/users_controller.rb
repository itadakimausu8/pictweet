class UsersController < ApplicationController

  def show
  #showアクションはマイページやツイートページなどの個々のページを表示したいときに使うアクション。
  user = User.find(params[:id])
  #Userクラスはモデル(user.rb)に定義されているもので、findメソッドを使うために呼び出されている。
  @nickname = user.nickname
  #userレコードのnicknameカラムにあるデータを呼び出している。
  #@nicknameにuser.nicknameを代入している。
  @tweets = user.tweets.page(params[:page]).per(5).order("created_at DESC")
    #user.tweetsはアソシエーションである。
    #userインスタンスに紐づいているtweetsインスタンスをすべて配列で呼び出している。
    #page&perメソッドはgemのkaminariを導入したときにモデルクラスに定義されるメソッドでページネーションを作るために使われる。
    #perメソッドの引数の中には1ページに入るインスタンスの数を指定することができる。
    #pageメソッドはページネーションのページ数を指定することができる。
    #リクエストをするときparamsの中にpageというキーが追加され、値が入れられる。
    #その値がページ番号となる。
    #なのでpage(page[:page])と記述する。
    #orderメソッドは順番の並び替えを指定することができる。
    #.order("カラム名 ソート式")
    #ソート式にはASC(昇順)DESC(降順)がある。
    # ↑の場合だと作った時間を基準に降順に並び替えるという意味になる。

    #上記すべての情報を組み合わせたものを@tweets(配列)に代入する。
  end

end
