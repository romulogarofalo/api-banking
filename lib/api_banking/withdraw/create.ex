defmodule ApiBanking.Withdraw.Create do
  alias ApiBanking.{Repo, Withdraw}

  def call(params) do
    %Withdraw{}
    |> Withdraw.changeset(params)
    # check if balance is below than 0 (maybe this line should be on schema?)
    |> Repo.insert()
  end
end
