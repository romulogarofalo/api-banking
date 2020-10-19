defmodule ApiBanking.Withdraw.Create do
  alias ApiBanking.{Repo, Withdraw}

  def call(params, user_id) do
    params_with_id = put_id_sender_in_params(params, user_id)

    %Withdraw{}
    |> Withdraw.changeset(params_with_id)
    |> Repo.insert()
  end

  defp put_id_sender_in_params(%{"amount" => amount}, user_id) do
    %{
      "amount" => amount,
      "user_id" => user_id
    }
  end
end
