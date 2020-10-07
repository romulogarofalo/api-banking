defmodule ApiBankingWeb.UserController do
  use ApiBankingWeb, :controller

  alias ApiBankingWeb.Auth.Guardian
  def create(conn, params) do
    with {:ok, user} <- ApiBanking.create_user(params),
         {:ok, token, _decoded} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("created.json", %{user: user, token: token})
    end
  end

end
