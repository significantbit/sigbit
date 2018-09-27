Sigbit::Engine.routes.draw do
  devise_for :users, class_name: "Sigbit::User", module: :devise
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do

    resources :nodes, module: :nodes do
      resource :sort, only: [:update]
      resource :publish, only: [:update]
    end

    resources :users
    root to: "dashboards#show"
  end
end
