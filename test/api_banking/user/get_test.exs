defmodule ApiBanking.CreateTest do
  use ApiBanking.DataCase

  alias ApiBanking.{Repo, User}
  alias User.Get

  describe("get/1") do
    test "when all params are valid, creates a trainer" do
      params = %{username: "romulo", password: "123123"}
      response = Get.call(params)
      assert {:ok, %User{username: "romulo"}, token: token} = response
    end
  end
end
