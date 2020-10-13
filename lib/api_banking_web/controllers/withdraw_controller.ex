defmodule ApiBakingWeb.WithdrawController do
  use ApiBankingWeb, :controller

  action_fallback ApiBankingWeb.FallbackController

  def create(conn, params) do
    {:ok, withdraw} = ApiBanking.Withdraw.Create.call(params)

    conn
    |> put_status(:created)
    |> render("created.json", %{withdraw: withdraw})
  end
end
