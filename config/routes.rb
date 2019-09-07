Rails.application.routes.draw do
  
  scope module: :event do
    controller :time do
      get 'repeat_form', action: 'repeat_form'
    end
    resources :plans do
      get :calendar, on: :collection
      get 'calendar' => :show_calendar, on: :member
    end
    resources :time_items, only: [:index] do
      collection do
        get :select
      end
    end
  end

  scope :admin, module: 'event/admin', as: :admin do
    resources :time_lists do
      resources :time_items
    end
    resources :time_items, only: [] do
      get :default, on: :collection
    end
    resources :places
    resources :plans
    resources :plan_items do
      patch :qrcode, on: :member
      resources :time_bookings do
        delete '' => :destroy, on: :collection
      end
      resources :plan_attenders do
        delete '' => :destroy, on: :collection
      end
    end
    resources :crowds do
      resources :crowd_members
    end
    resources :event_taxons
    resources :events do
      get :plan, on: :collection
      resources :event_participants do
        post :check, on: :collection
        post :attend, on: :collection
        patch :quit, on: :member
        delete '' => :destroy, on: :collection
      end
      resources :event_items do
      end
    end
    resources :event_items, only: [] do
      member do
        get 'plan' => :edit_plan
        patch 'plan' => :update_plan
        delete 'plan' => :destroy_plan
      end
    end
  end

  scope :my, module: 'event/my', as: :my do
    resources :time_plans
  end

  scope :member, module: 'event/member', as: :member do
    resources :plan_items
  end
  
end
