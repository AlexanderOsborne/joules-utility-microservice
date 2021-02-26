class Bill
  attr_reader :start_date,
              :end_date,
              :kwh,
              :meter_uid,
              :user_uid

  def initialize(data)
    @start_date = data[:base][:bill_start_date]
    @end_date = data[:base][:bill_end_date]
    @kwh = data[:base][:bill_total_kwh]
    @meter_uid = data[:meter_uid]
    @user_id = data[:authorization_uid]
  end

end