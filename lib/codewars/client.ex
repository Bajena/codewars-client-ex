defmodule Codewars.Client do
  defstruct token: nil, endpoint: "https://www.codewars.com/api/v1"

  @type t :: %__MODULE__{token: binary, endpoint: binary}

  @spec new() :: t
  def new(), do: %__MODULE__{}

  @spec new(binary) :: t
  def new(token), do: %__MODULE__{token: token}
end
