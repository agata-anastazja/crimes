defmodule Crimes.CrimeController do
  use Crimes.Web, :controller

  alias Crimes.Crime

  def index(conn, _params) do
    categories = Repo.all(Crime)
    render(conn, "index.html", categories: categories)
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
