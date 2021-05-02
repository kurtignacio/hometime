module Api
    module V1
        class GuestsController < ApplicationController
            def index
                guests = Guest.order('created_at desc');
                render json: {status: 'SUCCESS', data:guests},status: :ok
            end
        end
    end
end