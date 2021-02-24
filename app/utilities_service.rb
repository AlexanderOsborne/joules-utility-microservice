require 'sinatra'

class UtilitiesService < Sinatra::Base
  def new_user
    # call all 7 below it
  end

  def existing_user
    # only calls a few of them
  end
  
  def post_form(auth_param)
    require pry; binding.pry
  end

  def post_auth

  end

  def get_auth_and_meters

  end

  def post_activate_meters

  end

  def get_poll_meter

  end

  def get_bills

  end
end

