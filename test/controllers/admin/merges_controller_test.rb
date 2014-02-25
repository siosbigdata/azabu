require 'test_helper'

class Admin::MergesControllerTest < ActionController::TestCase
  setup do
    @merge = merges(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:merges)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create merge" do
    assert_difference('Merge.count') do
      post :create, merge: { graphtype: @merge.graphtype, linewidth: @merge.linewidth, name: @merge.name, template: @merge.template, term: @merge.term, title: @merge.title, useshadow: @merge.useshadow, usetip: @merge.usetip, useval: @merge.useval, y_min: @merge.y_min, y_unit: @merge.y_unit }
    end

    assert_redirected_to merge_path(assigns(:merge))
  end

  test "should show merge" do
    get :show, id: @merge
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @merge
    assert_response :success
  end

  test "should update merge" do
    patch :update, id: @merge, merge: { graphtype: @merge.graphtype, linewidth: @merge.linewidth, name: @merge.name, template: @merge.template, term: @merge.term, title: @merge.title, useshadow: @merge.useshadow, usetip: @merge.usetip, useval: @merge.useval, y_min: @merge.y_min, y_unit: @merge.y_unit }
    assert_redirected_to merge_path(assigns(:merge))
  end

  test "should destroy merge" do
    assert_difference('Merge.count', -1) do
      delete :destroy, id: @merge
    end

    assert_redirected_to merges_path
  end
end
