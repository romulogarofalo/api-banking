defmodule ApiBankingWeb.ReportsController do
  use ApiBankingWeb, :controller
  alias ApiBanking.Repo

  action_fallback ApiBankingWeb.FallbackController

  def get(conn, %{"initial_date" => initial_date, "final_date" => final_date}) do
    %{permission: permission} = Guardian.Plug.current_resource(conn)
    IO.inspect(permission)

    case permission do
      permi when permi == "admin" ->
        %{rows: row} =
          Ecto.Adapters.SQL.query!(
            Repo,
            "SELECT sum(total_amount) as total_amount, sum(total_transactions) as total_transactions FROM reports WHERE inserted_at BETWEEN '#{
              initial_date
            }' and '#{final_date}'",
            []
          )

        results = Enum.at(row, 0)

        report = %{
          total_amount: Enum.at(results, 0),
          total_transactions: Enum.at(results, 1)
        }

        conn
        |> put_status(:ok)
        |> render("get.json", report)

      permi when permi == "user" ->
        conn
        |> put_status(:forbiden)
        |> render("forbiden.json")
    end
  end
end
