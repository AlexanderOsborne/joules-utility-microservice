class BillsSerializer
  include FastJsonapi::ObjectSerializer
  set_id { nil }
  attributes :start_date, :end_date, :kwh, :meter_uid, :user_uid
end