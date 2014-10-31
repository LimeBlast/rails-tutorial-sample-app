module API
  module V1
    class Users < Grape::API
      version 'v1'
      format :json

      resource :users do
        desc 'Return list of activated users'
        get do
          User.where(activated: true).all
        end
      end
    end
  end
end
