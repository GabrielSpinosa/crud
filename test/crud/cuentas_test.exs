defmodule Crud.CuentasTest do
  use Crud.DataCase

  alias Crud.Cuentas

  describe "usuarios" do
    alias Crud.Cuentas.Usuarios

    @valid_attrs %{nombre: "some nombre", pass: "some pass", usuario: "some usuario"}
    @update_attrs %{nombre: "some updated nombre", pass: "some updated pass", usuario: "some updated usuario"}
    @invalid_attrs %{nombre: nil, pass: nil, usuario: nil}

    def usuarios_fixture(attrs \\ %{}) do
      {:ok, usuarios} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cuentas.create_usuarios()

      usuarios
    end

    test "list_usuarios/0 returns all usuarios" do
      usuarios = usuarios_fixture()
      assert Cuentas.list_usuarios() == [usuarios]
    end

    test "get_usuarios!/1 returns the usuarios with given id" do
      usuarios = usuarios_fixture()
      assert Cuentas.get_usuarios!(usuarios.id) == usuarios
    end

    test "create_usuarios/1 with valid data creates a usuarios" do
      assert {:ok, %Usuarios{} = usuarios} = Cuentas.create_usuarios(@valid_attrs)
      assert usuarios.nombre == "some nombre"
      assert usuarios.pass == "some pass"
      assert usuarios.usuario == "some usuario"
    end

    test "create_usuarios/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cuentas.create_usuarios(@invalid_attrs)
    end

    test "update_usuarios/2 with valid data updates the usuarios" do
      usuarios = usuarios_fixture()
      assert {:ok, %Usuarios{} = usuarios} = Cuentas.update_usuarios(usuarios, @update_attrs)
      assert usuarios.nombre == "some updated nombre"
      assert usuarios.pass == "some updated pass"
      assert usuarios.usuario == "some updated usuario"
    end

    test "update_usuarios/2 with invalid data returns error changeset" do
      usuarios = usuarios_fixture()
      assert {:error, %Ecto.Changeset{}} = Cuentas.update_usuarios(usuarios, @invalid_attrs)
      assert usuarios == Cuentas.get_usuarios!(usuarios.id)
    end

    test "delete_usuarios/1 deletes the usuarios" do
      usuarios = usuarios_fixture()
      assert {:ok, %Usuarios{}} = Cuentas.delete_usuarios(usuarios)
      assert_raise Ecto.NoResultsError, fn -> Cuentas.get_usuarios!(usuarios.id) end
    end

    test "change_usuarios/1 returns a usuarios changeset" do
      usuarios = usuarios_fixture()
      assert %Ecto.Changeset{} = Cuentas.change_usuarios(usuarios)
    end
  end
end
