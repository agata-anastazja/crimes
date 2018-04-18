# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PoliceRecords.Repo.insert!(%PoliceRecords.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


defmodule Seeds do

  alias Crimes.Crime
  alias Crimes.Repo


  def import_from_csv(csv_path) do
    File.stream!(Path.expand(csv_path))
    |> CSV.decode(separator: ?,, headers: true) #[:crime_id, :month, :reported_by, :falls_within, :longitude, :latitude, :location, :lsao_code, :lsao_name, :crime_type, :last_outcome_category, :context])
    |> Enum.map(fn (item) ->
      Crime.changeset(%Crime{}, %{crime_id: item["Crime ID"],
                                  month: item["Month"],
                                  reported_by: item["Reported by"],
                                  falls_within: item["Falls within"],
                                  longitude: item["Longitude"],
                                  latitude: item["Latitude"],
                                  location: item["Location"],
                                  LSOA_code: item["LSOA code"],
                                  LSOA_name: item["LSOA name"],
                                  crime_type: item["Crime type"],
                                  last_outcome_category:
                                  item["Last outcome category"],
                                  context: item["Context"]})
      |>Repo.insert
    end)
  end
end

Seeds.import_from_csv("data/2017-06/2017-06-city-of-london-street.csv")
