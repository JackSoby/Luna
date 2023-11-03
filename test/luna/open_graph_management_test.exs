defmodule Luna.OpenGraphManagementTest do
  use Luna.DataCase

  alias Luna.OpenGraphManagement

  describe "open_graph" do
    alias Luna.OpenGraphManagement.OpenGraph

    import Luna.OpenGraphManagementFixtures

    @invalid_attrs %{status: nil, url: nil, image_url: nil}

    test "list_open_graph/0 returns all open_graph" do
      open_graph = open_graph_fixture()
      assert OpenGraphManagement.list_open_graph() == [open_graph]
    end

    test "get_open_graph!/1 returns the open_graph with given id" do
      open_graph = open_graph_fixture()
      assert OpenGraphManagement.get_open_graph!(open_graph.id) == open_graph
    end

    test "create_open_graph/1 with valid data creates a open_graph" do
      valid_attrs = %{status: "some status", url: "some url", image_url: "some image_url"}

      assert {:ok, %OpenGraph{} = open_graph} = OpenGraphManagement.create_open_graph(valid_attrs)
      assert open_graph.status == "some status"
      assert open_graph.url == "some url"
      assert open_graph.image_url == "some image_url"
    end

    test "create_open_graph/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = OpenGraphManagement.create_open_graph(@invalid_attrs)
    end

    test "update_open_graph/2 with valid data updates the open_graph" do
      open_graph = open_graph_fixture()
      update_attrs = %{status: "some updated status", url: "some updated url", image_url: "some updated image_url"}

      assert {:ok, %OpenGraph{} = open_graph} = OpenGraphManagement.update_open_graph(open_graph, update_attrs)
      assert open_graph.status == "some updated status"
      assert open_graph.url == "some updated url"
      assert open_graph.image_url == "some updated image_url"
    end

    test "update_open_graph/2 with invalid data returns error changeset" do
      open_graph = open_graph_fixture()
      assert {:error, %Ecto.Changeset{}} = OpenGraphManagement.update_open_graph(open_graph, @invalid_attrs)
      assert open_graph == OpenGraphManagement.get_open_graph!(open_graph.id)
    end

    test "delete_open_graph/1 deletes the open_graph" do
      open_graph = open_graph_fixture()
      assert {:ok, %OpenGraph{}} = OpenGraphManagement.delete_open_graph(open_graph)
      assert_raise Ecto.NoResultsError, fn -> OpenGraphManagement.get_open_graph!(open_graph.id) end
    end

    test "change_open_graph/1 returns a open_graph changeset" do
      open_graph = open_graph_fixture()
      assert %Ecto.Changeset{} = OpenGraphManagement.change_open_graph(open_graph)
    end
  end
end
