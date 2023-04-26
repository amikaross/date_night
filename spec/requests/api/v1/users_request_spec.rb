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

  it "will return an error if the email sent for creation is not unique" do 
    create(:user, email: 'amanda@example.com')

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

  it "can return a user (if the session cookie matches)" do 
    user = create(:user, email: 'amanda@example.com')

    user_params = {
      email: 'amanda@example.com',
      password: 'password'
    }

    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/sessions", headers: headers, params: JSON.generate(user: user_params)

    get "/api/v1/users/#{user.id}"
    
    parsed_response = JSON.parse(response.body, symbolize_names: true)

    expect(parsed_response[:data][:id].to_i).to eq(user.id)
    expect(parsed_response[:data][:type]).to eq("user")
    expect(parsed_response[:data][:attributes][:email]).to eq(user.email)
  end

  it "will return an error if the user does not exist" do 
    5.times { create(:user) }

    test_id = User.last.id + 10

    get "/api/v1/users/#{test_id}"

    parsed_response = JSON.parse(response.body, symbolize_names: true)
    
    expect(response.status).to eq(404)
    expect(parsed_response[:message]).to eq("Resource Not Found")
    expect(parsed_response[:errors]).to eq(["user does not exist."])
  end

  it "will return an error if the user has not logged in (the session id does not exist or match)" do 
    user = create(:user, email: 'amanda@example.com')

    get "/api/v1/users/#{user.id}"
    
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(response.status).to eq(400)
    expect(parsed_response[:message]).to eq("Not Authorized")
    expect(parsed_response[:errors]).to eq(["Authorization to access this resource has not been received."])
  end
end