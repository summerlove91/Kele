require 'httparty'

class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1/sessions'

  def initialize(email, password)
    response = self.class.post("https://www.bloc.io/api/v1/sessions", body: {"email": email, "password": password})
    raise "Invalid email or password" if response.code == 404
    @auth_token = response["auth_token"]
  end


end
