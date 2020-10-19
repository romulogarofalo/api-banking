defmodule ApiBankingWeb.Controllers.WithdrawControllerTest do
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

    test "when send correct params, create a new withdraw", %{conn: conn} do
      params = [amount: 555]

      response =
        conn
        |> post(Routes.withdraw_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "message" => "Success withdraw",
               "withdraw" => %{
                 "amount" => 55500
               }
             } = response
    end
  end
end
