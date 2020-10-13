defmodule ApiBanking.Withdraw do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiBanking.User

  schema "withdraw" do
    field :amount, Money.Ecto.Amount.Type
    belongs_to :user_id, User, foreign_key: :user_id_id
    timestamps()
  end

  @required_attrs [:amount, :user_id]

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)

    # |> check_balance_below_zero
  end

  # def check_balance_below_zero(changeset) do
  # end
end
