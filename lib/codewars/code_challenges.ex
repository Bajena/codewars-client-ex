defmodule Codewars.CodeChallenges do
  import Codewars
  alias Codewars.Client

  @spec completed(Client.t, String.t, integer) :: Codewars.response
  def completed(client, username, page \\ 0) do
    get("/users/" <> username <> "/code-challenges/completed", client, [{:page, page}])
  end

  @spec authored(Client.t, String.t) :: Codewars.response
  def authored(client, username) do
    get("/users/" <> username <> "/code-challenges/authored", client)
  end

  @spec find(Client.t, String.t) :: Codewars.response
  def find(client, id) do
    get("/code-challenges/" <> id, client)
  end
end
