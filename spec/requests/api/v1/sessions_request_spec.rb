require "rails_helper"

RSpec.describe "Users API" do 
  it "can login an existing user if sent correct email/password" do 
    user = create(:user, email: 'amanda@example.com')

    # a second user that won't be logged in to show the correct user is returned
    create(:user)

    user_params = {
      email: 'amanda@example.com',
      password: 'password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    expect(User.all.count).to eq(2)

    post "/api/v1/sessions", headers: headers, params: JSON.generate(user: user_params)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(parsed_response[:data][:id].to_i).to eq(user.id)
    expect(parsed_response[:data][:type]).to eq("user")
    expect(parsed_response[:data][:attributes][:email]).to eq(user.email)
    expect(response.cookies).to have_key("_session_id")
  end

  it "returns an error if the user doesn't exist" do 
    5.times { create(:user) }
    user = create(:user, email: 'amanda@example.com')
    
    user_params = {
      email: 'amanda@not_an_example.com',
      password: 'password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/sessions", headers: headers, params: JSON.generate(user: user_params)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(400)
    expect(parsed_response[:message]).to eq("Bad Credentials")
  end

  it "returns an error if the user exists but the password is incorrect" do 
    5.times { create(:user) }
    user = create(:user, email: 'amanda@example.com')

    user_params = {
      email: 'amanda@example.com',
      password: 'not_a_password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/sessions", headers: headers, params: JSON.generate(user: user_params)

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(400)
    expect(parsed_response[:message]).to eq("Bad Credentials")
  end
end