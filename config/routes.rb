Rails.application.routes.draw do


  scope module: :rails_booking, controller: :time do
    get 'repeat_form', action: 'repeat_form'
  end


end
