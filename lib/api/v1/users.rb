module API
  module V1
    module Entities
      class Users < Grape::Entity
        expose :id
        expose :name
        expose :microposts_count, as: :microposts
        expose :activated_at, as: :activated
        expose :admin
      end
    end

    class Users < Grape::API
      version 'v1'

      resource :users do
        desc 'Return list of activated users'
        get do
          users = User.where(activated: true).all

          present users, with: API::V1::Entities::Users
        end
      end
    end
  end
end
