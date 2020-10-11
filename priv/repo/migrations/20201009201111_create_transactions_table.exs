defmodule ApiBanking.Repo.Migrations.CreateTransactionsTable do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :username_sender_id, references(:users)
      add :username_reciever_id, references(:users)
      add :amount, :integer
      timestamps()
    end

  end
end
