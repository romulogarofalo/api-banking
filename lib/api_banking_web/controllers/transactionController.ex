defmodule ApiBankingWeb.TransactionController do
  use ApiBankingWeb, :controller

  action_fallback ApiBankingWeb.FallbackController

  def create(conn, params) do
    token = get_req_header(conn, "authorization")
    user_sender_id = get_id_from_token(token)

    with {:ok, transaction} <- ApiBanking.Transaction.Create.call(params, user_sender_id) do
      conn
      |> put_status(:created)
      |> render("created.json", %{transaction: transaction})
    end
  end

  defp get_id_from_token(token_in_list) do
    bearer_token = Enum.at(token_in_list, 0)
    token = String.slice(bearer_token, 7..String.length(bearer_token))

    {:ok, %{"sub" => idUser}} =
      ApiBankingWeb.Auth.Guardian.decode_and_verify(token, %{"typ" => "access"})

    idUser
  end
end
