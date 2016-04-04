class RequestsControllerTest < ActionController::TestCase
  test "Should get index" do
    get :index
    assert_response :success
  end

  test "Creates offer request and returns offers " do
    post :create, request: {uid: 1, pub0: "campaign1", page: 1}
    assert_response :success
    assert_not_nil assigns(:offer_request)
    assert_not_nil assigns(:offer_response)
  end

end