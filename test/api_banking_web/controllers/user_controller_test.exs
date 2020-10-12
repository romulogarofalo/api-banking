defmodule ApiBankingWeb.Controllers.UserControllerTest do
  use ApiBankingWeb.ConnCase

  describe "create" do
    test "when send correct params for the first time, create a new user, return user and token 200",
         %{conn: conn} do
      params = [username: "romulo", password: "123123"]

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(201)

      assert %{
               "message" => "User Created",
               "token" => _token,
               "user" => %{"id" => _id, "inserted_at" => _date, "user" => "romulo"}
             } = response
    end
  end
end
