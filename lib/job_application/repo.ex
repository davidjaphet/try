defmodule JobApplication.Repo do
  use Ecto.Repo,
    otp_app: :job_application,
    adapter: Ecto.Adapters.Postgres
end
