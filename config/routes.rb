Rails.application.routes.draw do


  scope module: :booking do
    controller :time do
      get 'repeat_form', action: 'repeat_form'
    end
    scope ':plan_type/:plan_id' do
      resources :time_plans do
        get :calendar, on: :collection
        get 'calendar' => :show_calendar, on: :member
      end
      resources :plan_items do
        patch :qrcode, on: :member
      end
    end
    resources :plan_items, only: [] do
      resources :time_bookings do
        delete '' => :destroy, on: :collection
      end
      resources :plan_attenders do
        delete '' => :destroy, on: :collection
      end
    end
    resources :time_items, only: [:index] do
      collection do
        get :select
      end
    end
  end

  scope :admin, module: 'booking/admin', as: :admin do
    resources :time_lists do
      resources :time_items
    end
    resources :time_items, only: [] do
      get :default, on: :collection
    end
    resources :rooms
  end

  scope :my, module: 'booking/my', as: :my do
    resources :time_plans
  end

  scope :member, module: 'booking/member', as: :member do
    resources :plan_items
  end


end
