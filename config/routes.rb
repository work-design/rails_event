Rails.application.routes.draw do


  scope module: :booking, controller: :time do
    get 'repeat_form', action: 'repeat_form'
  end

  scope :admin, module: 'booking/admin', as: :admin do

  end


end
