defmodule ApiBanking.TransactionTest do
  use ApiBanking.DataCase

  alias ApiBanking.{User, Transaction}

  describe "changeset/1" do
    test "when all params are valid, returns a valid transaction" do
      params_to_create_user_1 = %{username: "romulo", password: "123123", permission: "user"}
      params_to_create_user_2 = %{username: "romulo2", password: "123123", permission: "user"}

      {:ok, %ApiBanking.User{id: user_sender_id}} = User.Create.call(params_to_create_user_1)

      {:ok, %ApiBanking.User{username: user_name_receiver}} =
        User.Create.call(params_to_create_user_2)

      params = %{
        "amount" => 500,
        "username_reciever_name" => user_name_receiver,
        "username_sender_id" => user_sender_id
      }

      response = Transaction.changeset(%Transaction{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 amount: %Money{
                   amount: 500,
                   currency: :BRL
                 },
                 username_reciever_id: _id,
                 username_reciever_name: user_name_receiver,
                 username_sender_id: user_sender_id
               },
               errors: [],
               data: %ApiBanking.Transaction{},
               valid?: true
             } = response
    end

    test "when all params are valid but not enogh balance, returns a invalid transaction" do
      params_to_create_user_1 = %{username: "romulo", password: "123123", permission: "user"}
      params_to_create_user_2 = %{username: "romulo2", password: "123123", permission: "user"}

      {:ok, %ApiBanking.User{id: user_sender_id}} = User.Create.call(params_to_create_user_1)

      {:ok, %ApiBanking.User{username: user_name_receiver}} =
        User.Create.call(params_to_create_user_2)

      params = %{
        "amount" => 150_000,
        "username_reciever_name" => user_name_receiver,
        "username_sender_id" => user_sender_id
      }

      response = Transaction.changeset(%Transaction{}, params)

      assert %Ecto.Changeset{
               changes: %{
                 amount: %Money{
                   amount: 150_000,
                   currency: :BRL
                 },
                 username_reciever_name: user_name_receiver,
                 username_sender_id: user_sender_id
               },
               errors: [{:amount, {"your account can't be below than 0 balance", []}}],
               data: %ApiBanking.Transaction{},
               valid?: false
             } = response
    end
  end
end
