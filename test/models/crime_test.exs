defmodule Crimes.CrimeTest do
  use Crimes.ModelCase

  alias Crimes.Crime

  @valid_attrs %{context: "some context", crime_id: "some crime_id", crime_type: "some crime_type", falls_within: "some falls_within", last_outcome_category: "some last_outcome_category", latitude: "120.5", location: "some location", longitude: "120.5", lsoa_code: "some lsoa_code", lsoa_name: "some lsoa_name", month: "some month", reported_by: "some reported_by"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Crime.changeset(%Crime{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Crime.changeset(%Crime{}, @invalid_attrs)
    refute changeset.valid?
  end
end
