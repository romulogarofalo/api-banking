defmodule ApiBankingWeb.WithdrawView do
  use ApiBankingWeb, :view

  alias ApiBanking.Withdraw

  def render("created.json", %{
        withdraw: %Withdraw{
          id: id,
          amount: %{amount: amount},
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Success withdraw",
      withdraw: %{
        id_transaction: id,
        amount: amount,
        inserted_at: inserted_at
      }
    }
  end
end
