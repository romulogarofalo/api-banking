defmodule ApiBankingWeb.FallbackController do
  use ApiBankingWeb, :controller

  def call(
        conn,
        {:error, %Ecto.Changeset{errors: [username: {"can't be blank", _params}]} = changeset}
      ) do
    conn
    |> put_status(400)
    |> put_view(ApiBankingWeb.ChangesetView)
    |> render("400.json", changeset: changeset)
  end

  def call(
        conn,
        {:error,
         %Ecto.Changeset{errors: [username: {"has already been taken", _params}]} = changeset}
      ) do
    conn
    |> put_status(409)
    |> put_view(ApiBankingWeb.ChangesetView)
    |> render("400.json", changeset: changeset)
  end

  def call(conn, {:error, %Ecto.Changeset{errors: _errors} = changeset}) do
    conn
    |> put_status(422)
    |> put_view(ApiBankingWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, result}) do
    IO.inspect("entrei no fallback 2")

    conn
    |> put_status(:bad_request)
    |> put_view(ApiBankingWeb.ErrorView)
    |> render("400.json", result: result)
  end
end
