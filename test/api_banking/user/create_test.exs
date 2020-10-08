defmodule ApiBanking.CreateTest do
  use ApiBanking.DataCase

  alias ApiBanking.{Repo, User}
  alias User.Create

  describe "call/1" do
    test "when all params are valid, creates a trainer" do
      params = %{username: "romulo", password: "123123"}

      count_before = Repo.aggregate(User, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(User, :count)

      assert {:ok, %User{username: "romulo"}} = response
      assert count_after > count_before
    end
  end
end
