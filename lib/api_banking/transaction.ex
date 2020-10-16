defmodule ApiBanking.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiBanking.{Repo, User}
  alias ApiBanking.Services.Balance

  schema "transactions" do
    field :amount, Money.Ecto.Amount.Type
    field :username_reciever_name, :string, virtual: true
    belongs_to :username_sender, User, foreign_key: :username_sender_id
    belongs_to :username_reciever, User, foreign_key: :username_reciever_id

    timestamps()
  end

  @required_attrs [:username_reciever_name, :username_sender_id, :amount]

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> check_balance_below_zero()
    |> get_ids_users()
  end

  defp check_balance_below_zero(changeset) do
    %{changes: %{amount: %Money{amount: amount}}} = changeset

    validate_change(changeset, :username_sender_id, fn :username_sender_id, user_id ->
      case Balance.getBalance(user_id) do
        balance when balance - amount >= 0 ->
          []

        balance when balance - amount < 0 ->
          [amount: "your account can't be below than 0 balance"]
      end
    end)
  end

  defp get_ids_users(changeset) do
    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{
          username_reciever_name: username_reciever
        }
      } ->
        %{id: user_id} = Repo.get_by(User, %{username: username_reciever})

        put_change(changeset, :username_reciever_id, user_id)

      _ ->
        changeset
    end
  end
end
