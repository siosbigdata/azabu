require 'test_helper'

class Admin::MergegraphsControllerTest < ActionController::TestCase
  setup do
    @mergegraph = mergegraphs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mergegraphs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mergegraph" do
    assert_difference('Mergegraph.count') do
      post :create, mergegraph: { graph_id: @mergegraph.graph_id, merge_id: @mergegraph.merge_id, side: @mergegraph.side, vieworder: @mergegraph.vieworder, y: @mergegraph.y }
    end

    assert_redirected_to mergegraph_path(assigns(:mergegraph))
  end

  test "should show mergegraph" do
    get :show, id: @mergegraph
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mergegraph
    assert_response :success
  end

  test "should update mergegraph" do
    patch :update, id: @mergegraph, mergegraph: { graph_id: @mergegraph.graph_id, merge_id: @mergegraph.merge_id, side: @mergegraph.side, vieworder: @mergegraph.vieworder, y: @mergegraph.y }
    assert_redirected_to mergegraph_path(assigns(:mergegraph))
  end

  test "should destroy mergegraph" do
    assert_difference('Mergegraph.count', -1) do
      delete :destroy, id: @mergegraph
    end

    assert_redirected_to mergegraphs_path
  end
end
