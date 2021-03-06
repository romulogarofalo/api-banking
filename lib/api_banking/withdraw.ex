defmodule ApiBanking.Withdraw do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiBanking.User
  alias ApiBanking.Services.Balance

  schema "withdraw" do
    field :amount, Money.Ecto.Amount.Type
    belongs_to :user_id_token, User, foreign_key: :user_id
    timestamps()
  end

  @required_attrs [:amount, :user_id]

  def changeset(withdraw, attrs) do
    withdraw
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> validade_amount()
    |> check_balance_below_zero()
  end

  defp validade_amount(changeset) do
    validate_change(changeset, :amount, fn :amount, money ->
      IO.inspect(money)

      case money do
        %Money{amount: amount} when amount > 0 ->
          []

        %Money{amount: amount} when amount <= 0 ->
          [amount: "the amount can't be below than 0"]
      end
    end)
  end

  defp check_balance_below_zero(changeset) do
    %{changes: %{amount: %Money{amount: amount}}} = changeset

    validate_change(changeset, :user_id, fn :user_id, user_id ->
      case Balance.getBalance(user_id) do
        balance when balance - amount >= 0 ->
          []

        balance when balance - amount < 0 ->
          [amount: "your account can't be below than 0 balance"]
      end
    end)
  end
end
