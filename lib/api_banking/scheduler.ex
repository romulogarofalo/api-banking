defmodule ApiBanking.Scheduler do
  use Quantum, otp_app: :api_banking
  alias ApiBanking.Repo

  def test do
    %{rows: rows_cash_out} =
      Ecto.Adapters.SQL.query!(
        Repo,
        "SELECT count(*), sum(amount + 0) FROM transactions WHERE inserted_at BETWEEN NOW() and NOW() - INTERVAL '1 DAY';",
        []
      )

    count_transactions = Enum.at(Enum.at(rows_cash_out, 0), 0) || 0
    sum_transactions = Enum.at(Enum.at(rows_cash_out, 0), 1) || 0

    IO.inspect("geting reports")

    Ecto.Adapters.SQL.query!(
      Repo,
      "INSERT INTO reports (total_transactions, total_amount) values
      (#{count_transactions}, #{sum_transactions})",
      []
    )
  end
end
