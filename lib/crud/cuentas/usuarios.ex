defmodule Crud.Cuentas.Usuarios do
  use Ecto.Schema
  import Ecto.Changeset

  schema "usuarios" do
    field :nombre, :string
    field :pass, :string
    field :usuario, :string

    timestamps()
  end

  @doc false
  def changeset(usuarios, attrs) do
    usuarios
    |> cast(attrs, [:usuario, :pass, :nombre])
    |> validate_required([:usuario, :pass, :nombre])
  end
end
