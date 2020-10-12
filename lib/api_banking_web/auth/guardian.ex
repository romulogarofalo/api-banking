defmodule ApiBankingWeb.Auth.Guardian do
  use Guardian, otp_app: :api_banking
  alias ApiBanking.{User, Repo}

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => sub}) do
    {:ok, Repo.get!(User, sub)}
  end
end
