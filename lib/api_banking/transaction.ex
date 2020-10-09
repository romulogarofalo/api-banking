defmodule ApiBanking.Transctions do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, ApiBanking.Money.Ecto.Amount.Type
    field :username_sender, :integer
    field :username_reciever, :integer
    belongs_to :user, Transctions, foreign_key: :username_sender, references: :id
    belongs_to :user, Transctions, foreign_key: :username_reciever, references: :id
    timestamps()
  end
end
