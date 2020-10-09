defmodule ApiBanking.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :username_sender, references(:users)
      add :username_reciever, references(:users)
      add :amount, :integer
      timestamps()
    end

  end
end
