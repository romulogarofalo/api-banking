defmodule ApiBanking do
  alias ApiBanking.{User, Transaction}

  defdelegate create_user(params), to: User.Create, as: :call
  defdelegate get_user(params), to: User.Get, as: :call
  defdelegate create_transaction(params, sender_id), to: Transaction.Create, as: :call
end
