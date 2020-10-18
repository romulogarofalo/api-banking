defmodule ApiBanking.User.GetTest do
  use ApiBanking.DataCase

  alias ApiBanking.User
  alias User.Get
  alias User.Create

  describe("get/1") do
    test "when all params are valid, get a user" do
      params_to_create = %{username: "romulo", password: "123123", permission: "admin"}
      params = %{"username" => "romulo", "password" => "123123"}

      Create.call(params_to_create)

      response = Get.call(params)
      assert {:ok, %User{username: "romulo"}} = response
    end

    test "when credential is wrong, get a trainer" do
      params_to_create = %{username: "romulo", password: "123123", permission: "admin"}
      params = %{"username" => "romulo123", "password" => "123123"}

      Create.call(params_to_create)

      response = Get.call(params)
      assert {:error, [message: "wrong credentials"]} = response
    end
  end
end
