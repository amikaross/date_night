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
    expect(created_user.email).to eq('amanda@example.com')
  end
end