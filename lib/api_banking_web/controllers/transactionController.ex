defmodule ApiBankingWeb.TransactionController do
  use ApiBankingWeb, :controller

  action_fallback ApiBankingWeb.FallbackController

  def create(%{req_headers: headers} = conn, params) do
    user_sender_id = get_id_from_token(headers)
    {:ok, transaction} = ApiBanking.create_transaction(params, user_sender_id)

    conn
    |> put_status(:created)
    |> render("created.json", %{transaction: transaction})
  end

  defp get_id_from_token(headers) do
    bearer_token = elem(Enum.at(headers, 1), 1)
    token = String.slice(bearer_token, 7..String.length(bearer_token))

    {:ok, %{"sub" => idUser}} =
      ApiBankingWeb.Auth.Guardian.decode_and_verify(token, %{"typ" => "access"})

    idUser
  end
end