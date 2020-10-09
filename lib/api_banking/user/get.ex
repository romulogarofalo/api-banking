defmodule ApiBanking.User.Get do
  alias ApiBanking.{Repo, User}

  def call(params) do
    user = get_user_by_username(params)

    check_password(user, params)
    |> handle_check(user)
  end

  # defp valid_params(params) do
  #  params
  # end

  defp get_user_by_username(%{"password" => _password, "username" => username}) do
    Repo.get_by(User, %{username: username})
  end

  defp check_password(%{password_hash: password_hash}, %{"password" => password}) do
    Comeonin.Bcrypt.checkpw(password, password_hash)
  end

  defp check_password(nil, _params), do: false

  defp handle_check(true, user), do: {:ok, user}
  defp handle_check(false, _user), do: {:error, message: "wrong credentials"}

  # fazer funcao com pattern para true e false e retornando um ok com user ou error com message de wrong credentials
end
