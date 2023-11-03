defmodule Luna.OpenGraphManagementFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Luna.OpenGraphManagement` context.
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
      |> Luna.OpenGraphManagement.create_open_graph()

    open_graph
  end
end
