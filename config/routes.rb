Rails.application.routes.draw do
  scope module: :users, constraints: proc { |req| User.current ||= User.find_by(id: req.session[:user_id]) } do
    resource :profile, only: %i[update edit show]
    root to: 'profiles#show'
  end

  # scope module: :moderators, constraints: proc { User.current&.moderator? } do
  #   root to: 'users#index', as: :moderators_root
  # end

  scope constraints: proc { !User.current } do
    get 'sign_up' => 'sign_up#new', as: :sign_up
    post 'sign_up' => 'sign_up#create'
    get 'sign_in' => 'sign_in#new', as: :sign_in
    post 'sign_in' => 'sign_in#create'
  end
end
