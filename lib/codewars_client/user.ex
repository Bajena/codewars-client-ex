defmodule CodewarsClient.User do
  import CodewarsClient

  defstruct [:clan, :codeChallenges, :honor, :leaderboardPosition, :name, :ranks, :skills, :username]

  @doc """
    Gets a single user
    ## Example
        Tentacat.Users.find client, "edgurgel"
        Tentacat.Users.find client, "iurifq"
    More info at: http://developer.github.com/v3/users/#get-a-single-user
    """
  @spec find(String.t) :: CodewarsClient.User.t | nil
  def find(username) do
    resp = get("/users/" <> username)
    case resp do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> { :ok, struct(CodewarsClient.User, body), resp }
      {_, %HTTPoison.Response{status_code: code}} -> { :error, 404, resp }
    end
  end
end
