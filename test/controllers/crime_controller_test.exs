defmodule Crimes.CrimeControllerTest do
  use Crimes.ConnCase

  alias Crimes.Crime
  @valid_attrs %{context: "some context", crime_id: "some crime_id", crime_type: "some crime_type", falls_within: "some falls_within", last_outcome_category: "some last_outcome_category", latitude: "120.5", location: "some location", longitude: "120.5", lsoa_code: "some lsoa_code", lsoa_name: "some lsoa_name", month: "some month", reported_by: "some reported_by"}
  @invalid_attrs %{}

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, crime_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing categories"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, crime_path(conn, :new)
    assert html_response(conn, 200) =~ "New crime"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, crime_path(conn, :create), crime: @valid_attrs
    crime = Repo.get_by!(Crime, @valid_attrs)
    assert redirected_to(conn) == crime_path(conn, :show, crime.id)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, crime_path(conn, :create), crime: @invalid_attrs
    assert html_response(conn, 200) =~ "New crime"
  end

  test "shows chosen resource", %{conn: conn} do
    crime = Repo.insert! %Crime{}
    conn = get conn, crime_path(conn, :show, crime)
    assert html_response(conn, 200) =~ "Show crime"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, crime_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    crime = Repo.insert! %Crime{}
    conn = get conn, crime_path(conn, :edit, crime)
    assert html_response(conn, 200) =~ "Edit crime"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    crime = Repo.insert! %Crime{}
    conn = put conn, crime_path(conn, :update, crime), crime: @valid_attrs
    assert redirected_to(conn) == crime_path(conn, :show, crime)
    assert Repo.get_by(Crime, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    crime = Repo.insert! %Crime{}
    conn = put conn, crime_path(conn, :update, crime), crime: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit crime"
  end

  test "deletes chosen resource", %{conn: conn} do
    crime = Repo.insert! %Crime{}
    conn = delete conn, crime_path(conn, :delete, crime)
    assert redirected_to(conn) == crime_path(conn, :index)
    refute Repo.get(Crime, crime.id)
  end
end
