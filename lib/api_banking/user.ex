defmodule ApiBanking.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :hashed_password, :string
    field :username, :string
    field :password, :string, virtual: true
    timestamps()
  end

  @required_attrs [:username, :password]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> unique_constraint(:username)
    |> put_hashed_password()
  end

  defp put_hashed_password(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
