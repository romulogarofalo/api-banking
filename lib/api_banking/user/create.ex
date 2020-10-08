defmodule ApiBanking.User.Create do
  alias ApiBanking.{Repo, User}

  def call(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end
end
