defmodule Crud.Repo do
  use Ecto.Repo,
    otp_app: :crud,
    adapter: Ecto.Adapters.Tds
end
