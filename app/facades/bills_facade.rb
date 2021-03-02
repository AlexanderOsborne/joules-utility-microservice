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
      data = UtilitiesService.get_bills(meter)[:bills]
      data.map do |bill|
        Bill.new(bill)
      end
    end

  end
end