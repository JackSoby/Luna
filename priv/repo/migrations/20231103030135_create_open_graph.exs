defmodule Luna.Repo.Migrations.CreateOpenGraph do
  use Ecto.Migration

  def change do
    create table(:open_graph) do
      add :status, :string
      add :url, :string
      add :image_url, :string

      timestamps()
    end
  end
end
