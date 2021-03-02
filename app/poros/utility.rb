class Utility
  attr_reader :id,
              :utility_name

  def initialize(data)
    @id = data[:id]
    @utility_name = data[:name]
  end
end
