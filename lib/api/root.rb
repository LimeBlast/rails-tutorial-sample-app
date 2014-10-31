module API
  class Root < Grape::API
    prefix 'api'
    format :json
    default_format :json

    mount API::V1::Root
    # mount API::V2::Root (next version)

    route :any, '*path' do
      error! 'Not Found', 404
    end
  end
end
