defmodule Luna.Repo.Migrations.CreateGraph do
  use Ecto.Migration

  def change do
    create table(:graph) do
      add :status, :string
      add :url, :text
      add :image_url, :text

      timestamps()
    end
  end
end
