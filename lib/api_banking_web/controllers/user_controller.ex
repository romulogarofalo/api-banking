defmodule ApiBankingWeb.UserController do
  use ApiBankingWeb, :controller

  action_fallback ApiBankingWeb.FallbackController

  alias ApiBankingWeb.Auth.Guardian

  def create(conn, params) do
    with {:ok, user} <- ApiBanking.User.Create.call(params),
         {:ok, token, _decoded} <- Guardian.encode_and_sign(user) do
      conn
      |> put_status(:created)
      |> render("created.json", %{user: user, token: token})
    end
  end

  def login(conn, params) do
    with {:ok, user} <- ApiBanking.get_user(params),
         {:ok, token, _decoded} <- Guardian.encode_and_sign(user) do
      IO.inspect("send email to confirm sign up")

      conn
      |> put_status(:ok)
      |> render("authenticated.json", %{user: user, token: token})
    end
  end
end
