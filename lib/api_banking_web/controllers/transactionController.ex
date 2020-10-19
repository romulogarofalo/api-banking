defmodule ApiBankingWeb.TransactionController do
  use ApiBankingWeb, :controller

  action_fallback ApiBankingWeb.FallbackController

  def create(conn, params) do
    %{id: user_sender_id} = Guardian.Plug.current_resource(conn)

    with {:ok, transaction} <- ApiBanking.Transaction.Create.call(params, user_sender_id) do
      conn
      |> put_status(:created)
      |> render("created.json", %{transaction: transaction})
    end
  end
end
