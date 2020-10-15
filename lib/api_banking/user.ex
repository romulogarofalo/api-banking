defmodule ApiBanking.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :password_hash, :string
    field :username, :string
    field :permission, :string
    field :password, :string, virtual: true
    timestamps()
  end

  @required_attrs [:username, :password, :permission]

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> validate_permission()
    |> unique_constraint(:username)
    |> put_password_hash()
  end

  defp validate_permission(changeset) do
    validate_change(changeset, :permission, fn :permission, permission ->
      case permission do
        permi when permi == "admin" ->
          []

        permi when permi == "user" ->
          []

        _ ->
          [permission: "should be user or admin"]
      end
    end)
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
