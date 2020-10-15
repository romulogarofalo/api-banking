defmodule ApiBanking.Services.Balance do
  alias ApiBanking.Repo

  def getBalance(user_id) do
    cash_out = get_cash_out(user_id)
    cash_in = get_cash_in(user_id)
    initial_balance = get_initial_balance(user_id)

    cash_in + initial_balance - cash_out
  end

  defp get_cash_out(user_id) do
    %{rows: rows_cash_out} =
      Ecto.Adapters.SQL.query!(
        Repo,
        "SELECT amount FROM transactions WHERE username_sender_id = #{user_id}",
        []
      )

    Enum.reduce(rows_cash_out, 0, fn xs, acumulador -> Enum.at(xs, 0) + acumulador end)
  end

  defp get_cash_in(user_id) do
    %{rows: rows_cash_in} =
      Ecto.Adapters.SQL.query!(
        Repo,
        "SELECT amount FROM transactions WHERE username_reciever_id = #{user_id}",
        []
      )

    Enum.reduce(rows_cash_in, 0, fn xs, acumulador -> Enum.at(xs, 0) + acumulador end)
  end

  defp get_initial_balance(user_id) do
    %{rows: balance} =
      Ecto.Adapters.SQL.query!(
        Repo,
        "SELECT balance FROM users WHERE id = #{user_id}",
        []
      )

    Enum.at(Enum.at(balance, 0), 0)
  end
end
