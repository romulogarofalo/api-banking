defmodule ApiBanking.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiBanking.{Repo, User}

  schema "transactions" do
    field :amount, Money.Ecto.Amount.Type
    # maybe this shoud be a string, if the required get the type from here
    belongs_to :username_sender, User, foreign_key: :username_sender_id
    belongs_to :username_reciever, User, foreign_key: :username_reciever_id
    field :username_reciever_name, :string, virtual: true

    timestamps()
  end

  @required_attrs [:username_reciever, :amount]

  def changeset(transaction, attrs, sender_id) do
    transaction
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> get_ids_users(attrs, sender_id)

    # |> update_changeset()
  end

  defp get_ids_users(
         %{username_reciever: username_reciever, amount: amount} = changeset,
         _attrs,
         sender_id
       ) do
    {:ok, user} = Repo.get_by(User, %{username: username_reciever})

    case changeset do
      %Ecto.Changeset{
        valid?: true,
        changes: %{
          username_sender_id: _sender_id,
          username_reciever_id: _reciever_id,
          amount: _amount
        }
      } ->
        put_change(changeset, :username_sender_id, sender_id)
        put_change(changeset, :username_reciever_id, user.id)
        put_change(changeset, :amount, %Money{currency: :BRL, amount: amount})

      _ ->
        changeset
    end
  end
end
