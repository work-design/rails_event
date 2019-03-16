Rails.application.routes.draw do


  scope module: :booking, controller: :time do
    get 'repeat_form', action: 'repeat_form'
  end

  scope :admin, module: 'booking/admin', as: :admin do
    resources :time_lists do
      resources :time_items
    end
    resources :time_plans
  end


end
