module Api
    module V1
        class ReservationsController < ApplicationController
            def index
                reservations = Reservation.order('created_at desc');
                render json: {status: 'SUCCESS', data:reservations},status: :ok
            end

            def create
                reqData = YAML.load(request.body)

                if !reqData["reservation"].nil?
                    r = Reservation.save_format1(reqData)
                else
                    r = Reservation.save_format2(reqData) 
                end

                reservation = Reservation.find_by_id r

                if !reservation.nil?
                   render json: {status: 'SUCCESS', message: "Reservation Saved! ID: #{r}"},status: :ok
                else
                    render json: {status: 'ERROR', data:r},status: :unprocessable_entity
                end

            end
            
        end
    end
end