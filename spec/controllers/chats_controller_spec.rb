require 'rails_helper'

RSpec.describe ChatsController, type: :controller do

  describe "GET #room" do
    it "returns http success" do
      get :room
      expect(response).to have_http_status(:success)
    end
  end

end
