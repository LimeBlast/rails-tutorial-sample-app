module API
  module V1
    module Entities
      class User < Grape::Entity
        expose :id
        expose :name
        expose :activated_at, as: :activated
        expose :admin
        expose :microposts_count
      end

      class Micropost < Grape::Entity
        expose :id
        expose :content
        expose :created_at
      end

      class Feed < Grape::Entity
        expose :id
        expose :content
        expose :created_at
        expose :user, using: 'API::V1::Entities::User', as: :user
      end
    end
  end
end
