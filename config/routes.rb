Sigbit::Engine.routes.draw do
  devise_for :users, class_name: "Sigbit::User", module: :devise
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :nodes do
      member do
        get "move_higher"
        get "move_lower"
        post "publish"
      end
    end
    resources :users
    resource :settings
    root to: "dashboards#show"
  end
end
