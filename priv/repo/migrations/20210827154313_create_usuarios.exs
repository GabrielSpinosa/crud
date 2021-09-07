defmodule Crud.Repo.Migrations.CreateUsuarios do
  use Ecto.Migration

  def change do
    create table(:usuarios) do
      add :usuario, :string
      add :pass, :string
      add :nombre, :string

      timestamps()
    end

  end
end
