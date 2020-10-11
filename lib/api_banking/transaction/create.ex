defmodule ApiBanking.Transaction.Create do
  alias ApiBanking.{Repo, Transaction}

  def call(params, sender_id) do
    params_with_id = put_id_sender_in_params(params, sender_id)

    %Transaction{}
    |> Transaction.changeset(params_with_id)
    |> Repo.insert()
  end

  defp put_id_sender_in_params(
         %{"amount" => amount, "username_reciever_name" => username},
         sender_id
       ) do
    %{
      "amount" => amount,
      "username_reciever_name" => username,
      "username_sender_id" => sender_id
    }
  end
end
