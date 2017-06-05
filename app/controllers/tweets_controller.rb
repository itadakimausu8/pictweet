class TweetsController < ApplicationController

  before_action :move_to_index,except: :index
  #before_actionはこのコントローラーがアクションをする前に処理を挟むことができる。
  #オプションはexceptなのでindexアクションは除く。他にifやonlyがある。
  #↑の場合だと「indexアクション以外が処理する前にmove_to_indexメソッドを動かせ」
  #という意味になる。
  def index
    @tweets = Tweet.includes(:user).page(params[:page]).per(5).order("created_at DESC")
    #Tweetクラスはモデル(tweet.rb)に定義されているもので、includes,orderメソッドを使うために呼び出されている。
    #includesメソッドは引数にモデル名を記述することで、そのモデルのSQL発行回数を減らすことができる。(n+1問題の解消)
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

  def new
    #newアクション：主にform画面などユーザーにデータを記述させるときに使うアクション
    #アクションの中身が空っぽのときは省略することができる。
  end

  def create
    #createアクション：データを保存するときに使う。
    Tweet.create(image: tweet_params[:image], text: tweet_params[:text],user_id:current_user.id)
    #Tweetクラスはモデル(tweet.rb)に定義されているもので、createメソッドを使うために呼び出されている。
    #createメソッドはデータを保存するために使われるメソッド。
    #create(カラム名 データ)で指定したカラム名にデータを保存することができる。
    #上の場合だとimageカラムにtweet_params[:iamge]、textカラムにtweet_params[:text]のデータを保存している。
    #tweet_paramsについては下記参照。
    #また、user_idカラムにはcurrent_user.idのデータを保存している。
    #current_userはdeviseを導入することで使うことができるヘルパーメソッドで
    #ログインしているユーザーのインスタンスとして扱うことができる。
    #このアプリケーションの場合だと
    #current_user = User.find(ログインしているユーザーのid)
    #したがって、current_user.id = ログインしているuserのidの値となる。
  end

  def destroy
    #destroyアクション：削除など、データを消去する処理を行うときに使う。
      tweet = Tweet.find(params[:id])
    #Tweetクラスはモデル(tweet.rb)に定義されているもので、findメソッドを使うために呼び出されている。
    #findメソッドはレシーバのモデルから引数のidに基づいてそのidのレコードをインスタンスとして呼び出すことができる。
    #params[:id]はroutingのネストより呼び出されたもので削除リンクが押されたTweetインスタンスのidとなる。

    #↑の場合だと削除するTweetモデルインスタンスをtweetに代入する形になる。
      if tweet.user_id == current_user.id
    #tweetには削除されるTweetモデルのインスタンスが代入されている。
    #tweet.user_id = tweetの投稿者のid
    #current_user.id = ログインしているユーザー(削除リンクを押したユーザー)のid
    #条件： tweetの投稿者のid == 削除リンクを押したユーザーのid。
    #つまり、上記の条件が成り立つときtweet.destroyを処理するという意味になる。
        tweet.destroy
    #destroyメソッドは指定したレコードを削除することができる。
      end
  end

  def edit
    #editアクションは編集画面を表示するときなどに使うアクション。
    @tweet = Tweet.find(params[:id])
    #Tweet.find(params[:id])については上記参照。
    #@tweetに右辺の情報を代入する。
  end

  def update
    #updateアクションはデータを更新する処理を行うときに使うアクション。
    tweet = Tweet.find(params[:id])
    #Tweetクラスはモデル(tweet.rb)に定義されているもので、find,updateメソッドを使うために呼び出されている。
      if tweet.user_id == current_user.id
    #基本的構造はdestroyアクションと同じなので省略。
        tweet.update(tweet_params)
    #updateメソッドはデータの内容を更新するときに使うメソッド。
    #update(カラム名 更新する内容)で更新することができる。
    #もしくはupdate({ カラム名 = 値 })のようにハッシュ値で更新することも可能。
    #上記の場合はtweet_params(ハッシュ値)を使っている。
    #ハッシュ値はcreateメソッドでもできる。
      end
  end

  def show
    #showアクションはマイページやツイートページなどの個々のページを表示したいときに使うアクション。
    @tweet = Tweet.find(params[:id])
    #Tweet.find(params[:id])については上記参照。
    #@tweetにTweet.find(params[:id])を代入。
    @comments = @tweet.comments.includes(:user )
    #@tweetの中には詳細を見たいtweetのインスタンスが代入されている。
    #@tweet.commentsはアソシエーションで表されており、
    #@代入されたtweetインスタンスに紐づいたcommentインスタンスの配列が
    #呼び出されている。(詳細を見たいtweetのコメントをすべて呼び出す。)
    #includesメソッドによってSQLの発行回数を減らしている。

    #上記の内容を@commentsに代入する。
  end

  private
  #privateメソッドは記述より下に書いてある処理を他クラスから呼び出せないようにするメソッド。
  #使うことで外部から守る、可読性を上げることができる。
  def tweet_params
  #tweet_paramsメソッドを定義する。
    params.permit(:image,:text)
  #permitメソッドとは引数に記述されているparamsのキーだけを残して、新たなハッシュ値として再定義することができる。
  #permitを利用することでストロングパラメーターを実装することができる。
  #↑の場合だとimageカラムとtextカラムのみのハッシュ値を作り直すことができる。
  end

  def move_to_index
    #move_to_indexメソッドを定義する。
    redirect_to action: :index unless user_signed_in?
    #指定されたページにリダイレクトさせることができる。
    #unless = ifの逆
    #unless 条件 は条件がfalseのとき処理させることができる。
    #user_signed_in?はdeviseを導入したときに使えるヘルパーメソッド
    #user_signed_in?はユーザーがログインしていたらtrue,
    #ログインしていなければfalse。

    #したがって、↑は次のような意味になる。
    #もし、ユーザーがログインしていなければindexアクションを動かせ。
  end

end