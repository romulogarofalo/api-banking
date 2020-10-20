defmodule ApiBanking.Repo.Migrations.CreateReportsTable do
  use Ecto.Migration

  def change do
    create table(:reports) do
      add :total_amount, :integer
      add :total_transactions, :integer
      timestamps()
    end
  end
end
