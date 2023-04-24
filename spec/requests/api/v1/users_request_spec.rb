require "rails_helper"

RSpec.describe "Users API" do 
  it "can create a user" do 
    user_params = {
      email: 'amanda@example.com',
      password: 'password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    expect(User.all.count).to eq(0)

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    
    created_user = User.last 

    expect(User.all.count).to eq(1)
    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(created_user.email).to eq('amanda@example.com')
  end

  it "will return an error if the email is not unique" do 
    User.create(email: 'amanda@example.com', password: 'password')

    user_params = {
      email: 'amanda@example.com',
      password: 'another_password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    expect(User.all.count).to eq(1)

    post "/api/v1/users", headers: headers, params: JSON.generate(user: user_params)
    
    parsed_response = JSON.parse(response.body)

    expect(User.all.count).to eq(1)
    expect(response.status).to eq(400)
    expect(parsed_response["message"]).to eq("Bad Request")
    expect(parsed_response["errors"]).to eq(["Email has already been taken"])
  end
end