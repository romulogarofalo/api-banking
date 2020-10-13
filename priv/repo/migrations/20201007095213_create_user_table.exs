defmodule ApiBanking.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string
      add :password_hash, :string
      add :balance, :integer, default: 100000
      add :permission, :string

      timestamps()
    end

    create unique_index(:users, [:username])
  end
end
