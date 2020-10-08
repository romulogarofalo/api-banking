defmodule ApiBanking.User.Create do
  alias ApiBanking.{Repo, User}

  def call(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  defp create_user({:ok, struct}), do: Repo.insert(struct)
  defp create_user({:error, _changeset} = error), do: error
end
