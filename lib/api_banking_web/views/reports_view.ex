defmodule ApiBankingWeb.ReportsView do
  use ApiBankingWeb, :view

  @doc """
  Traverses and translates changeset errors.

  See `Ecto.Changeset.traverse_errors/2` and
  `ApiBankingWeb.ErrorHelpers.translate_error/1` for more details.
  """
  def render("get.json", %{
        total_amount: total_amount,
        total_transactions: total_transactions
      }) do
    %{
      message: "Reports data",
      reports: %{
        total_amount: total_amount,
        total_transactions: total_transactions
      }
    }
  end

  def render("forbinden.json", %{}) do
    %{
      message: "your user don't have permission"
    }
  end

  def translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, &translate_error/1)
  end
end
