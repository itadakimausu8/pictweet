Rails.application.routes.draw do

  devise_for :users
  # ↑ gemの「devise」をbundle installしたときに追加されるルーティング設定。
  #   devise関連のルーティング設定がすべてされている。
  #   new_user_session GET  /users/sign_in   devise/sessions#new
  #   user_session  POST   /users/sign_in devise/sessions#create
  #    など

  root 'tweets#index'
  # ↑ URLがルート(/)のときに動かすコントローラー,アクションの指定。

  resources :tweets do
  # ↑ tweetsコントローラーの７つのアクションのルーティングを指定する。
  #bundle exec rake routes
  #     tweets GET    /tweets(.:format)           tweets#index
  #            POST   /tweets(.:format)           tweets#create
  #  new_tweet GET    /tweets/new(.:format)       tweets#new
  # edit_tweet GET    /tweets/:id/edit(.:format)  tweets#edit
  #      tweet GET    /tweets/:id(.:format)       tweets#show
  #            PATCH  /tweets/:id(.:format)       tweets#update
  #            PUT    /tweets/:id(.:format)       tweets#update
  #            DELETE /tweets/:id(.:format)       tweets#destroy



    resources :comments, only: [:create]
    # ↑ commentsコントローラーの７つのアクションのうち,createアクションのみのルーティングを指定する。指定するオプションはonly。
    #↑ commentsコントローラーの７つのアクションのうち,createアクションのみのルーティングを指定する。指定するオプションはonly。
  end
  # ↑ doによってルーティングのネストが設定されている。
  #ネストとは入れ子構造に記述することである。
  #この場合だと「resouces :tweets」が「resouces :comments, only: [:create]」を囲んでいる状態である。
  #このように記述することで入れ子の中にあるコントローラー(この場合だとcomment)に入れ子の外にあるコントローラー(この場合だとtweets)に関連したインスタンスがどの情報なのか(tweet_id)を渡すことができる。


  resources :users,only: [:show]
  #↑ usersコントローラーの７つのアクションのうち,showアクションのみのルーティングを指定する。指定するオプションはonly。
end
