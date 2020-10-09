defmodule ApiBankingWeb.Controllers.UserControllerTest do
  use ApiBankingWeb.ConnCase

  describe "create" do
    test "when send correct params for the first time, create a new user, return user and token 200",
         %{conn: conn} do
      params = %{"username" => "romulo", "password" => "123123"}

      response =
        conn
        |> post("/api/signup", params)
        |> json_response(:created)

      assert response == "banana"
    end
  end
end
