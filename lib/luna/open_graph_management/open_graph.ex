defmodule Luna.OpenGraphManagement.OpenGraph do
  use Ecto.Schema
  import Ecto.Changeset

  schema "open_graph" do
    field :status, :string
    field :url, :string
    field :image_url, :string

    timestamps()
  end

  @doc false
  def changeset(open_graph, attrs) do
    open_graph
    |> cast(attrs, [:status, :url, :image_url])
    |> validate_required([:status, :url])
  end
end
