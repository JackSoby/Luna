defmodule Luna.Repo do
  use Ecto.Repo,
    otp_app: :luna,
    adapter: Ecto.Adapters.Postgres
end
