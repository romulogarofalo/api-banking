defmodule ApiBanking.WithdrawTest do
  use ApiBanking.DataCase

  alias ApiBanking.{User, Withdraw}

  describe "changeset/1" do
    test "when all params are valid, returns a valid Withdraw" do
      params_to_create_user = %{username: "romulo", password: "123123", permission: "user"}

      {:ok, %ApiBanking.User{id: user_id}} = User.Create.call(params_to_create_user)

      params = %{
        "amount" => 50000,
        "user_id" => user_id
      }

      response = Withdraw.changeset(%Withdraw{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 amount: %Money{
                   amount: 50000,
                   currency: :BRL
                 },
                 user_id: _id
               },
               errors: [],
               data: %ApiBanking.Withdraw{},
               valid?: true
             } = response
    end

    test "when all params are valid but not enogh balance, returns a invalid Withdraw" do
      params_to_create_user = %{username: "romulo", password: "123123", permission: "user"}

      {:ok, %ApiBanking.User{id: user_id}} = User.Create.call(params_to_create_user)

      params = %{
        "amount" => 150_000,
        "user_id" => user_id
      }

      response = Withdraw.changeset(%Withdraw{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 amount: %Money{
                   amount: 150_000,
                   currency: :BRL
                 }
               },
               errors: [{:amount, {"your account can't be below than 0 balance", []}}],
               data: %ApiBanking.Withdraw{},
               valid?: false
             } = response
    end
  end
end
