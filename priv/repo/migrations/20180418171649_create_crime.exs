defmodule Crimes.Repo.Migrations.CreateCrime do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :lsoa_code, :string
      add :lsoa_name, :string
      add :context, :string
      add :crime_id, :string
      add :crime_type, :string
      add :falls_within, :string
      add :last_outcome_category, :string
      add :latitude, :decimal
      add :location, :string
      add :longitude, :decimal
      add :month, :string
      add :reported_by, :string

      timestamps()
    end
  end
end
