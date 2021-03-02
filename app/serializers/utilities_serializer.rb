class UtilitiesSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :utility_name
end