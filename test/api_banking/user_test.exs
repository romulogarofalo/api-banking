defmodule ApiBanking.UserTest do
  use ApiBanking.DataCase

  alias ApiBanking.User

  describe "changeset/1" do
    test "when all params are valid, returns a valid changeset" do
      params = %{username: "romulo", password: "123123", permission: "admin"}

      response = User.changeset(%User{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 password: "123123",
                 username: "romulo"
               },
               errors: [],
               data: %ApiBanking.User{},
               valid?: true
             } = response
    end

    test "when username is  invalid, returns an invalid changeset" do
      params = %{username: "", password: "123123", permission: "admin"}

      response = User.changeset(%User{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 password: "123123"
               },
               data: %ApiBanking.User{},
               valid?: false
             } = response

      assert errors_on(response) == %{username: ["can't be blank"]}
    end

    test "when password is  invalid, returns an invalid changeset" do
      params = %{username: "romulo", password: "", permission: "admin"}

      response = User.changeset(%User{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 username: "romulo"
               },
               data: %ApiBanking.User{},
               valid?: false
             } = response

      assert errors_on(response) == %{password: ["can't be blank"]}
    end

    test "when permission is  invalid, returns an invalid changeset" do
      params = %{username: "romulo", password: "123123", permission: ""}

      response = User.changeset(%User{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 username: "romulo"
               },
               data: %ApiBanking.User{},
               valid?: false
             } = response

      assert errors_on(response) == %{permission: ["can't be blank"]}
    end
  end
end
