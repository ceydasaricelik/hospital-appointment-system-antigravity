Given('a registered user with email {string} and password {string}') do |email, password|
  @user = FactoryBot.create(:user, email: email, password: password, role: 'patient')
  FactoryBot.create(:patient, user: @user)
end

When('the client sends a POST request to {string} with:') do |path, table|
  params = table.rows_hash
  post path, params: params
end

Then('the response status should be {int}') do |status|
  expect(response.status).to eq(status)
end

Then('the response should include a JWT token') do
  json = JSON.parse(response.body)
  expect(json['token']).to be_present
end

Then('the response should include an error message {string}') do |message|
  json = JSON.parse(response.body)
  expect(json['error']).to eq(message)
end
