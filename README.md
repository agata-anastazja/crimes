# Crimes

To start your Phoenix app:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


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

<table class="table">
  <thead>
    <tr>
      <th> <%= link "Crime ID", to: crime_path(@conn, :index, params: [:crime_id]) %></th>
      <th> <%= link "Month", to: crime_path(@conn, :index, params: [:month]) %></th>
      <th> <%= link "crime_type", to: crime_path(@conn, :index, params: [:crime_type]) %></th>
      <th> <%= link "Reported by", to: crime_path(@conn, :index, params: [:reported_by]) %></th>
      <th><%= link "Context", to: crime_path(@conn, :index, params: [:context]) %></th>
      <th><%= link "Last outcome category", to: crime_path(@conn, :index, params: [:last_outcome_category]) %></th>
      <th><%= link "Location", to: crime_path(@conn, :index, params: [:location]) %></th>
    </tr>
  </thead>
  <tbody>