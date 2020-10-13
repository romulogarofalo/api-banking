defmodule ApiBanking.Repo.Migrations.CreateWithdrawTable do
  use Ecto.Migration

  def change do
    create table(:withdraw) do
      add :user_id, references(:users)
      add :amount, :integer
      timestamps()
    end
  end
end
