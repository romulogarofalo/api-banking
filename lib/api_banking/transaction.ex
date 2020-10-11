defmodule ApiBanking.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  alias ApiBanking.{Repo, User}

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
    |> get_ids_users()
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
