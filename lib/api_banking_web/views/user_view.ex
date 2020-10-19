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
end
