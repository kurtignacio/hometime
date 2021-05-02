class Reservation < ApplicationRecord
    belongs_to :guest

    validates :guest_id, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :payout_price, presence: true
    validates :security_price, presence: true
    validates :total_price, presence: true
    validates :currency, presence: true
    validates :nights, presence: true
    validates :guests, presence: true
    validates :adults, presence: true
    validates :children, presence: true
    validates :infants, presence: true
    validates :status, presence: true

    def self.save_format1(reqData)
        # Handle format 1

        @errors = []
        data = nil
        ActiveRecord::Base.transaction do
            res = reqData["reservation"]

            # Check if guest exists
            g = Guest.find_by_guest_id res["guest_id"]

            # Create guest if new
            if g.nil?
                g = Guest.create(
                    guest_id: res["guest_id"],
                    first_name: res["guest_first_name"],
                    last_name: res["guest_last_name"],
                    email: res["guest_email"],
                    phone: res["guest_phone_numbers"],
                )

                if g.errors.any?
                    @errors << g.errors.full_messages
                end
            end

            # Create reservation
            if !g.nil? && @errors.blank?
                r = g.reservations.create(
                    start_date: res["start_date"],
                    end_date: res["end_date"],
                    payout_price: res["expected_payout_amount"],
                    security_price: res["listing_security_price_accurate"],
                    total_price: res["total_paid_amount_accurate"],
                    currency: res["host_currency"],
                    nights: res["nights"],
                    guests: res["number_of_guests"],
                    adults: res["guest_details"]["number_of_adults"],
                    children: res["guest_details"]["number_of_children"],
                    infants: res["guest_details"]["number_of_infants"],
                    status: res["status_type"]
                )

                if r.errors.any?
                    @errors << r.errors.full_messages
                end
            end
            

            if @errors.blank?
                data = r.id
            else
                raise ActiveRecord::Rollback
            end
        end

        if @errors.blank?
            return data
        else
            return @errors
        end

    end

    def self.save_format2(res)
        # Handle format 2

        @errors = []
        data = nil
        ActiveRecord::Base.transaction do
            # Check if guest exists
            g = Guest.find_by_guest_id res["guest_id"]

            # Create guest if new
            if g.nil?
                g = Guest.create(
                    guest_id: res["guest"]["id"],
                    first_name: res["guest"]["first_name"],
                    last_name: res["guest"]["last_name"],
                    email: res["guest"]["email"],
                    phone: res["guest"]["phone"],
                )

                if g.errors.any?
                    @errors << g.errors.full_messages
                end
            end

            # Create reservation
            if !g.nil? && @errors.blank?
                r = g.reservations.create(
                    start_date: res["start_date"],
                    end_date: res["end_date"],
                    payout_price: res["payout_price"],
                    security_price: res["security_price"],
                    total_price: res["total_price"],
                    currency: res["currency"],
                    nights: res["nights"],
                    guests: res["guests"],
                    adults: res["adults"],
                    children: res["children"],
                    infants: res["infants"],
                    status: res["status"]
                )

                if r.errors.any?
                    @errors << r.errors.full_messages
                end
            end
            

            if @errors.blank?
                data = r.id
            else
                raise ActiveRecord::Rollback
            end
        end

        if @errors.blank?
            return data
        else
            return @errors
        end

    end

end
