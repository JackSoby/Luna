defmodule Luna.OpenGraphManagement do
  @moduledoc """
  The OpenGraphManagement context.
  """

  import Ecto.Query, warn: false
  alias Luna.Repo
  alias Luna.OpenGraphManagement.Graph

  @doc """
  Returns the list of open_graph.

  ## Examples

      iex> list_open_graph()
      [%OpenGraph{}, ...]

  """
  def list_open_graph do
    Graph
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Gets a single open_graph.

  Raises `Ecto.NoResultsError` if the Open graph does not exist.

  ## Examples

      iex> get_open_graph!(123)
      %Graph{}

      iex> get_open_graph!(456)
      ** (Ecto.NoResultsError)

  """
  def get_open_graph!(id), do: Repo.get!(Graph, id)

  @doc """
  Creates a open_graph.

  ## Examples

      iex> create_open_graph(%{field: value})
      {:ok, %Graph{}}

      iex> create_open_graph(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_open_graph(attrs \\ %{}) do
    %Graph{}
    |> Graph.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a open_graph.

  ## Examples

      iex> update_open_graph(open_graph, %{field: new_value})
      {:ok, %Graph{}}

      iex> update_open_graph(open_graph, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_open_graph(%Graph{} = open_graph, attrs) do
    open_graph
    |> Graph.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a open_graph.

  ## Examples

      iex> delete_open_graph(open_graph)
      {:ok, %Graph{}}

      iex> delete_open_graph(open_graph)
      {:error, %Ecto.Changeset{}}

  """
  def delete_open_graph(%Graph{} = open_graph) do
    Repo.delete(open_graph)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking open_graph changes.

  ## Examples

      iex> change_open_graph(open_graph)
      %Ecto.Changeset{data: %Graph{}}

  """
  def change_open_graph(%Graph{} = open_graph, attrs \\ %{}) do
    Graph.changeset(open_graph, attrs)
  end

  @doc """
  Process a graphs given URL.

  ## Examples

      iex> process_url(graph)

  """

  def process_url(%Graph{url: url} = open_graph) do
    case Finch.build(:get, url) |> Finch.request(Luna.Finch) do
      {:ok, %{body: body}} ->
        body
        |> OpenGraph.parse()
        |> parse_image(open_graph)
        |> send_graph_update_message

      {:error, _} ->
        open_graph
        |> update_open_graph(%{status: "failed"})
        |> send_graph_update_message
    end
  end

  defp parse_image(%OpenGraph{image: nil}, %Graph{} = open_graph) do
    open_graph
    |> update_open_graph(%{status: "failed"})
  end

  defp parse_image(%OpenGraph{image: url}, %Graph{} = open_graph) do
    open_graph
    |> update_open_graph(%{status: "success", image_url: url})
  end

  defp send_graph_update_message(
         {:ok, %Luna.OpenGraphManagement.Graph{image_url: url, id: id, status: status}}
       ) do
    LunaWeb.Endpoint.broadcast("open_graph_room:lobby", "open_graph_update", %{
      image_url: url,
      status: status,
      id: id
    })
  end
end
