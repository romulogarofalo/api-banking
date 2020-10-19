defmodule ApiBankingWeb.WithdrawController do
  use ApiBankingWeb, :controller

  action_fallback ApiBankingWeb.FallbackController

  def create(conn, params) do
    %{id: user_id} = Guardian.Plug.current_resource(conn)

    with {:ok, withdraw} <- ApiBanking.Withdraw.Create.call(params, user_id) do
      conn
      |> put_status(:created)
      |> render("created.json", %{withdraw: withdraw})
    end
  end
end
