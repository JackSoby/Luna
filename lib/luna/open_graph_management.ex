defmodule Luna.OpenGraphManagement do
  @moduledoc """
  The OpenGraphManagement context.
  """

  import Ecto.Query, warn: false
  alias Luna.Repo

  alias Luna.OpenGraphManagement.OpenGraph

  @doc """
  Returns the list of open_graph.

  ## Examples

      iex> list_open_graph()
      [%OpenGraph{}, ...]

  """
  def list_open_graph do
    OpenGraph
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single open_graph.

  Raises `Ecto.NoResultsError` if the Open graph does not exist.

  ## Examples

      iex> get_open_graph!(123)
      %OpenGraph{}

      iex> get_open_graph!(456)
      ** (Ecto.NoResultsError)

  """
  def get_open_graph!(id), do: Repo.get!(OpenGraph, id)

  @doc """
  Creates a open_graph.

  ## Examples

      iex> create_open_graph(%{field: value})
      {:ok, %OpenGraph{}}

      iex> create_open_graph(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_open_graph(attrs \\ %{}) do
    %OpenGraph{}
    |> OpenGraph.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a open_graph.

  ## Examples

      iex> update_open_graph(open_graph, %{field: new_value})
      {:ok, %OpenGraph{}}

      iex> update_open_graph(open_graph, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_open_graph(%OpenGraph{} = open_graph, attrs) do
    open_graph
    |> OpenGraph.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a open_graph.

  ## Examples

      iex> delete_open_graph(open_graph)
      {:ok, %OpenGraph{}}

      iex> delete_open_graph(open_graph)
      {:error, %Ecto.Changeset{}}

  """
  def delete_open_graph(%OpenGraph{} = open_graph) do
    Repo.delete(open_graph)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking open_graph changes.

  ## Examples

      iex> change_open_graph(open_graph)
      %Ecto.Changeset{data: %OpenGraph{}}

  """
  def change_open_graph(%OpenGraph{} = open_graph, attrs \\ %{}) do
    OpenGraph.changeset(open_graph, attrs)
  end
end
