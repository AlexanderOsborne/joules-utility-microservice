class UtilitySerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :utility_name
  binding.pry
end
