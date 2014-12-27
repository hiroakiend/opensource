require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  setup do
    @item = items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create item" do
    assert_difference('Item.count') do
      post :create, item: { client: @item.client, client_info: @item.client_info, delivery: @item.delivery, description: @item.description, end_date: @item.end_date, initial_price: @item.initial_price, introducer: @item.introducer, notes: @item.notes, proceedings: @item.proceedings, running_price: @item.running_price, start_date: @item.start_date, status: @item.status, subject: @item.subject }
    end

    assert_redirected_to item_path(assigns(:item))
  end

  test "should show item" do
    get :show, id: @item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @item
    assert_response :success
  end

  test "should update item" do
    patch :update, id: @item, item: { client: @item.client, client_info: @item.client_info, delivery: @item.delivery, description: @item.description, end_date: @item.end_date, initial_price: @item.initial_price, introducer: @item.introducer, notes: @item.notes, proceedings: @item.proceedings, running_price: @item.running_price, start_date: @item.start_date, status: @item.status, subject: @item.subject }
    assert_redirected_to item_path(assigns(:item))
  end

  test "should destroy item" do
    assert_difference('Item.count', -1) do
      delete :destroy, id: @item
    end

    assert_redirected_to items_path
  end
end
