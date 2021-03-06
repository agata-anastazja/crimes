import Ecto.Query

defmodule Crimes.CrimeController do
  use Crimes.Web, :controller

  alias Crimes.Crime


  def index(conn, params) do
    filter = params["filter"]
    if filter == nil do
      categories = Repo.all(Crime)
    else
      filter_atom = String.to_atom(filter)
      query = from crime in Crime, order_by: [{:asc, ^filter_atom}]
      categories = Repo.all(query)
    end
    search_term = params["query"]
    if search_term != "" and search_term != nil do
      categories = Repo.all(search(search_term))
    end
    render(conn, "index.html", categories: categories)
  end

  defp apply_filter(nil), do: Repo.all(Crime)
  defp apply_filter(filter) do
    query = from crime in Crime, order_by: [{:desc, ^filter}]
    Repo.all(query)
  end

  def search(search_term) do
    wildcard_search = "%#{search_term}%"

    from crime in Crime,
    where: ilike(crime.crime_id, ^wildcard_search),
    or_where: ilike(crime.month, ^wildcard_search),
    or_where: ilike(crime.crime_type, ^wildcard_search),
    or_where: ilike(crime.reported_by, ^wildcard_search),
    or_where: ilike(crime.context, ^wildcard_search),
    or_where: ilike(crime.last_outcome_category, ^wildcard_search),
    or_where: ilike(crime.location , ^wildcard_search)
  end

  def new(conn, _params) do
    changeset = Crime.changeset(%Crime{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"crime" => crime_params}) do
    changeset = Crime.changeset(%Crime{}, crime_params)

    case Repo.insert(changeset) do
      {:ok, crime} ->
        conn
        |> put_flash(:info, "Crime created successfully.")
        |> redirect(to: crime_path(conn, :show, crime))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    crime = Repo.get!(Crime, id)
    render(conn, "show.html", crime: crime)
  end

  def edit(conn, %{"id" => id}) do
    crime = Repo.get!(Crime, id)
    changeset = Crime.changeset(crime)
    render(conn, "edit.html", crime: crime, changeset: changeset)
  end

  def update(conn, %{"id" => id, "crime" => crime_params}) do
    crime = Repo.get!(Crime, id)
    changeset = Crime.changeset(crime, crime_params)

    case Repo.update(changeset) do
      {:ok, crime} ->
        conn
        |> put_flash(:info, "Crime updated successfully.")
        |> redirect(to: crime_path(conn, :show, crime))
      {:error, changeset} ->
        render(conn, "edit.html", crime: crime, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    crime = Repo.get!(Crime, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(crime)

    conn
    |> put_flash(:info, "Crime deleted successfully.")
    |> redirect(to: crime_path(conn, :index))
  end
end
