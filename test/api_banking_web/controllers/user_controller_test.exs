defmodule ApiBankingWeb.Controllers.UserControllerTest do
  use ApiBankingWeb.ConnCase

  describe "create" do
    test "when send correct params for the first time, create a new user, return user and token 200",
         %{conn: conn} do
      params = [username: "romulo", password: "123123", permission: "admin"]

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

    test "when send correct params but repeated username, create a new user, return user and token 200",
         %{conn: conn} do
      params = [username: "romulo", password: "123123", permission: "admin"]

      post(conn, Routes.user_path(conn, :create, params))

      response =
        conn
        |> post(Routes.user_path(conn, :create, params))
        |> json_response(409)

      assert %{"errors" => %{"username" => ["has already been taken"]}} = response
    end
  end

  describe "get" do
    test "when send correct params, to login", %{conn: conn} do
      params_to_create_user = [username: "romulo", password: "123123", permission: "admin"]
      params = [username: "romulo", password: "123123"]
      post(conn, Routes.user_path(conn, :create, params_to_create_user))

      response =
        conn
        |> post(Routes.user_path(conn, :login, params))
        |> json_response(200)

      assert %{"user" => %{"username" => _username}, "token" => _token} = response
    end

    test "when send wrong params, to login", %{conn: conn} do
      params_to_create_user = [username: "romulo", password: "123123", permission: "admin"]
      params = [username: "romuloAA", password: "123123"]
      post(conn, Routes.user_path(conn, :create, params_to_create_user))

      response =
        conn
        |> post(Routes.user_path(conn, :login, params))
        |> json_response(400)

      assert %{"errors" => %{"detail" => "Bad Request"}} = response
    end
  end
end
