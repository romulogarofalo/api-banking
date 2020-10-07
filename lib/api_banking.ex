defmodule ApiBanking do

  alias ApiBanking.User

  defdelegate create_user(params), to: User.Create, as: :call

end
