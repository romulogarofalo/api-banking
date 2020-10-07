defmodule ApiBankingWeb.Auth.Guardian do
  use Guardian, otp_app: :api_banking

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(_claims) do
    {:error, :reason_for_error}
  end
end
