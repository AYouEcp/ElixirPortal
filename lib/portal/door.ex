defmodule Portal.Door do
  @doc """
  Starts a door with the given `color`.

  The color is given as a name so we can identify
  the door by color name instead of using a PID.

  ## Example

      iex> Portal.Door.start_link(:color)
      {:ok, #PID<0.190.0>}

  """
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Get the data currently in the `door`.

  ## Example

      iex> Portal.Door.start_link(:color)
      {:ok, #PID<0.190.0>}
      iex> Portal.Door.push(:color, 1)
      :ok
      iex> Portal.Door.get(:color)
      [1]
  """
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into the door.

  ## Example

      iex> Portal.Door.start_link(:color)
      {:ok, #PID<0.190.0>}
      iex> Portal.Door.push(:color, 1)
      :ok
  """
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops a value from the `door`.

  Returns `{:ok, value}` if there is a value
  or `:error` if the hole is currently empty.
  """
  def pop(door) do
    Agent.get_and_update(door, fn
      []    -> {:error, []}
      [h|t] -> {{:ok, h}, t}
    end)
  end

  @doc """
  Empty the`door`.

  ## Example

      iex> Portal.Door.start_link(:color)
      {:ok, #PID<0.190.0>}
      iex> Portal.Door.push(:color, 1)
      :ok
      iex> Portal.Door.empty(:color)
      :ok
      iex> Portal.Door.get(:color)
      []
  """
  def empty(door) do
    Agent.update(door, fn _ -> [] end)
  end

end
