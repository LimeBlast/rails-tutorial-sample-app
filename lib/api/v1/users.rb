module API
  module V1
    class Users < Grape::API
      resource :users do
        desc 'Return list of activated users'
        get do
          users = User.where(activated: true).all
          present users, with: API::V1::Entities::Users
        end

        desc 'Return a user and their microposts.'
        params do
          requires :id, type: Integer, desc: 'User ID.'
        end
        route_param :id do
          get do
            user = User.includes(:microposts).find(params[:id])
            present user, with: API::V1::Entities::User
          end
          get :feed do
            feed = User.find(params[:id]).feed.includes(:user)
            present feed, with: API::V1::Entities::Feed
          end
        end
      end
    end
  end
end
