class CommentsController < ApplicationController
  def create
    #createアクション：データを保存するときに使う。
    @comment = Comment.create(text: params[:text],tweet_id: params[:tweet_id],user_id: current_user.id)
    #Commentクラスはモデル(comment.rb)に定義されているもので、createメソッドを使うために呼び出されている。
    #.create(text: params[:text],tweet_id: params[:tweet_id],user_id: current_user.id)についてはtweetコントローラーを参照。
    redirect_to "/tweets/#{@comment.tweet.id}"
    #redirect_to URL  で記述したURLにリダイレクトさせることができる。
    #@comment.tweet.idはアソシエーションである。
    #@commentの中に入っているインスタンス(コメント)に紐づいているtweetレコードのidを表示している。
    #↑の場合,自分がコメントしたツイートの詳細画面に飛ばすことができる
  end

  private
  #privateメソッドは記述より下に書いてある処理を他クラスから呼び出せないようにするメソッド。
  #使うことで外部から守る、可読性を上げることができる。

  def comment_params
    #comment_paramsメソッドを定義する。
      params.permit(:text,:tweet_id)
  #permitメソッドとは引数に記述されているparamsのキーだけを残して、新たなハッシュ値として再定義することができる。
  #permitを利用することでストロングパラメーターを実装することができる。
  #↑の場合だとtextカラムとtweet_idカラムのみのハッシュ値を作り直すことができる。
  end
end
