defmodule ApiBankingWeb.UserView do
  use ApiBankingWeb, :view

  alias ApiBanking.User

  def render("created.json", %{
        user: %User{
          id: id,
          username: user,
          inserted_at: inserted_at
        },
        token: token
      }) do
    %{
      message: "User Created",
      user: %{
        id: id,
        user: user,
        inserted_at: inserted_at
      },
      token: token
    }
  end

  def render("authenticated.json", %{
        user: %User{
          username: username
        },
        token: token
      }) do
    %{
      user: %{
        username: username
      },
      token: token
    }
  end

  # If you want to customize a particular status code
  # for a certain format, you may uncomment below.
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
end
