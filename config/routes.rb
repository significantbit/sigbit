Sigbit::Engine.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    resources :nodes
    root to: "dashboards#show"
  end
end
