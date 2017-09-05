require 'httparty'
require './lib/roadmap'
require 'json'

class Kele
  include HTTParty
  include Roadmap
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {"email": email, "password": password})
    raise "Invalid email or password" if response.code == 404
    @auth_token = response["auth_token"]
  end

  def get_me
    response = self.class.get("https://www.bloc.io/api/v1/users/me", headers: { "authorization" => @auth_token })
    @user_data = JSON.parse(response.body)
  end

  def get_mentor_availability(mentor_id)
    response = self.class.get("https://www.bloc.io/api/v1/mentors/#{mentor_id}/student_availability", headers: { "authorization" => @auth_token })
    @mentor_data = JSON.parse(response.body).to_a
    # mentor_id = 2299934
  end

end
