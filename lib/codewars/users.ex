defmodule Codewars.Users do
  import Codewars
  alias Codewars.Client

  @spec find(Client.t, String.t) :: Codewars.response
  def find(client \\ %Client{}, username) do
    get("/users/" <> username, client)
  end
end
