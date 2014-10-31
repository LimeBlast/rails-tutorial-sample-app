module API
  module V1
    class Users < Grape::API
      resource :user do
        desc 'Return list of activated users'
        get do
          users = User.where(activated: true).all
          present users, with: API::V1::Entities::User
        end

        params do
          requires :id, type: Integer, desc: 'User ID.'
        end

        route_param :id do
          desc 'Return a user.'
          get do
            user = User.find(params[:id])
            present user, with: API::V1::Entities::User
          end

          desc "Return a user's feed."
          get :feed do
            feed = User.find(params[:id]).feed.includes(:user)
            present feed, with: API::V1::Entities::Feed
          end

          desc "Return a user's microposts."
          get :micropost do
            microposts = User.find(params[:id]).microposts
            present microposts, with: API::V1::Entities::Micropost
          end
        end
      end
    end
  end
end
