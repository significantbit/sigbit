Sigbit::Engine.routes.draw do
  devise_for :users, class_name: "Sigbit::User", module: :devise
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    resources :nodes do
      resource :sort, module: :nodes, only: [:update]
      resource :publish, module: :nodes, only: [:update]
    end

    resources :users
    root to: "dashboards#show"
  end
end
