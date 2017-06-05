class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   before_action :configure_permitted_parameters, if: :devise_controller?
   #before_actionはこのコントローラーがアクションをする前に処理を挟むことができる。
   #オプションはif: :devise_controller?である。
   #コントローラー名?はそのコントローラーが動いていればtrue,動いていなければfalseを返す。

   #↑の場合「deviseコントローラーが動いているとき,アクションを動かす前にconfigure_permitted_parametersメソッドを動かす」ということになる。

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:nickname])
    #devise_parameter_sanitizerメソッドはdeviseの導入によって使うことができる。
    #使うことでdeviseのストロングパラメーターに対してパラメーターを追加することができる。
    #devise_parameter_sanitizer.permit(追加したいメソッドの指定,keys:[:追加したいパラメータ名])
    #追加したいメソッドは3種類ある。
    #:sign_up 新規登録時
    #:sign_in  ログイン時
    #:account_update レコードの更新時

    #↑の場合だとサインアップ時のストロングパラメーターにnicknameを追加する。
  end
end
