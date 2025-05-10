defmodule MySurvey.Repo do
  use Ecto.Repo,
    otp_app: :my_survey,
    adapter: Ecto.Adapters.Postgres
end
