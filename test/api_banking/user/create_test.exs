defmodule ApiBanking.User.CreateTest do
  use ApiBanking.DataCase

  alias ApiBanking.{Repo, User}
  alias User.Create

  describe "call/1" do
    test "when all params are valid, creates a trainer" do
      params = %{username: "romulo", password: "123123", permission: "admin"}

      count_before = Repo.aggregate(User, :count)

      response = Create.call(params)

      count_after = Repo.aggregate(User, :count)

      assert {:ok, %User{username: "romulo"}} = response
      assert count_after > count_before
    end

    test "when username is repeated" do
      params = %{username: "romulo", password: "123123", permission: "admin"}

      count_before = Repo.aggregate(User, :count)
      Create.call(params)
      response = Create.call(params)

      count_after = Repo.aggregate(User, :count)

      assert {:error,
              %{
                errors: [
                  username:
                    {"has already been taken",
                     [constraint: :unique, constraint_name: "users_username_index"]}
                ]
              }} = response

      assert count_after > count_before
    end
  end
end
