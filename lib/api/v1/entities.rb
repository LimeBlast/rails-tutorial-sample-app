module API
  module V1
    module Entities
      class Users < Grape::Entity
        expose :id
        expose :name
        expose :microposts_count
        expose :activated_at, as: :activated
        expose :admin
      end

      class User < Grape::Entity
        expose :id
        expose :name
        expose :activated_at, as: :activated
        expose :admin
        expose :microposts_count
        expose :microposts, using: 'API::V1::Entities::Microposts', as: :microposts
      end

      class Microposts < Grape::Entity
        expose :id
        expose :content
        expose :created_at
      end

      class Feed < Grape::Entity
        expose :id
        expose :content
        expose :created_at
        expose :user, using: 'API::V1::Entities::Users', as: :user
      end
    end
  end
end
