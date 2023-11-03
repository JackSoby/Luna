defmodule LunaWeb.UploadController do
  use LunaWeb, :controller
  alias Luna.OpenGraphManagement

  def index(conn, _params) do
    urls = OpenGraphManagement.list_open_graph()

    render(conn, :index, open_graphs: urls, token: get_csrf_token())
  end

  def create(conn, %{"url" => url, "_csrf_token" => token}) do
    case OpenGraphManagement.create_open_graph(%{url: url, status: "pending"}) do
      {:ok, %Luna.OpenGraphManagement.Graph{} = open_graph} ->
        Task.async(fn ->
          Process.sleep(400)
          OpenGraphManagement.process_url(open_graph)
        end)

        urls = OpenGraphManagement.list_open_graph()

        render(conn, :index, open_graphs: urls, token: token)

      _ ->
        urls = OpenGraphManagement.list_open_graph()

        conn
        |> put_flash(:error, "Error Creating Open Graph")
        |> render(:index, open_graphs: urls, token: token)
    end
  end
end
