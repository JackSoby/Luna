defmodule Luna.SchemaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Luna.Schema` context.
  """

  @doc """
  Generate a open_graph.
  """
  def open_graph_fixture(attrs \\ %{}) do
    {:ok, open_graph} =
      attrs
      |> Enum.into(%{
        image_url: "some image_url",
        status: "some status",
        url: "some url"
      })
      |> Luna.Schema.create_open_graph()

    open_graph
  end
end
