defmodule LunaWeb.UploadController do
  use LunaWeb, :controller
  alias Luna.OpenGraphManagement
  def index(conn, _params) do
   urls = OpenGraphManagement.list_open_graph
    # http_resp = HTTPoison.get! "https://www.facebook.com/jeff.dallas.100/"
    # res = OpenGraph.parse(http_resp.body)
    # IO.inspect(res)
    render(conn, :index, open_graphs: urls, token: get_csrf_token())
  end

  def create(conn, %{"url" => url, "_csrf_token" => token}) do
    OpenGraphManagement.create_open_graph(%{url: url, status: "pending"})

    urls = OpenGraphManagement.list_open_graph
    render(conn, :index, open_graphs: urls, token: token)
  end
end
