defmodule ApiBankingWeb.Controllers.TransactionControllerTest do
  use ApiBankingWeb.ConnCase
  alias ApiBankingWeb.Auth.Guardian
  alias ApiBanking.User

  describe "create" do
    setup %{conn: conn} do
      params_sender = %{username: "romulo", password: "123123", permission: "user"}
      {:ok, trainer} = User.Create.call(params_sender)

      {:ok, token, _claims} = Guardian.encode_and_sign(trainer)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")
      {:ok, conn: conn}
    end

    test "when send correct params, create a new transfer", %{conn: conn} do
      params_receiver = %{username: "romulo2", password: "123123", permission: "user"}
      {:ok, %ApiBanking.User{username: user_name_receiver}} = User.Create.call(params_receiver)

      params = [amount: 555, username_reciever_name: user_name_receiver]

      response =
        conn
        |> post(Routes.transaction_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "message" => "Success Transaction",
               "transaction" => %{
                 "amount" => 55500,
                 "username_reciever_name" => user_name_receiver
               }
             } = response
    end
  end
end
