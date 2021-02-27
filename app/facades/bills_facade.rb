class BillsFacade
  class << self
    def check_the_bills(params)
      meter = UtilitiesService.poll_meter(params[:meter_uid])
      if meter[:status] == "updated"
        bills(params[:meter_uid])
      elsif meter[:status] == "pending"
        "Bills aren't ready yet."
      elsif meter[:status] == "errored"
        "Something went wrong :/"
      end
    end

    def bills(meter)
      data = UtilitiesService.get_bills(meter)
      data[:bills].map do |bill| 
        {"start_date": bill[:base][:bill_start_date],
        "end_date": bill[:base][:bill_end_date],
        "kwh": bill[:base][:bill_total_kwh], 
        "meter_uid": bill[:meter_uid], 
        "user_uid": bill[:authorization_uid]}
      end
    end

  end
end