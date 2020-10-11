defmodule ApiBankingWeb.TransactionView do
  use ApiBankingWeb, :view

  alias ApiBanking.Transaction

  def render("created.json", %{
        transaction: %Transaction{
          id: id,
          amount: %{amount: amount},
          username_reciever_name: username_reciever_name,
          inserted_at: inserted_at
        }
      }) do
    %{
      message: "Success Transaction",
      transaction: %{
        id_transaction: id,
        amount: amount,
        username_reciever_name: username_reciever_name,
        inserted_at: inserted_at
      }
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
