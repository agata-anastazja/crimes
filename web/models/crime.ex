defmodule Crimes.Crime do
  use Crimes.Web, :model

  schema "categories" do
    field :lsoa_code, :string
    field :lsoa_name, :string
    field :context, :string
    field :crime_id, :string
    field :crime_type, :string
    field :falls_within, :string
    field :last_outcome_category, :string
    field :latitude, :decimal
    field :location, :string
    field :longitude, :decimal
    field :month, :string
    field :reported_by, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:lsoa_code, :lsoa_name, :context, :crime_id, :crime_type, :falls_within, :last_outcome_category, :latitude, :location, :longitude, :month, :reported_by])
  end
end
