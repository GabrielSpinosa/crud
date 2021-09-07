defmodule CrudWeb.UsuariosLiveTest do
  use CrudWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Crud.Cuentas

  @create_attrs %{nombre: "some nombre", pass: "some pass", usuario: "some usuario"}
  @update_attrs %{nombre: "some updated nombre", pass: "some updated pass", usuario: "some updated usuario"}
  @invalid_attrs %{nombre: nil, pass: nil, usuario: nil}

  defp fixture(:usuarios) do
    {:ok, usuarios} = Cuentas.create_usuarios(@create_attrs)
    usuarios
  end

  defp create_usuarios(_) do
    usuarios = fixture(:usuarios)
    %{usuarios: usuarios}
  end

  describe "Index" do
    setup [:create_usuarios]

    test "lists all usuarios", %{conn: conn, usuarios: usuarios} do
      {:ok, _index_live, html} = live(conn, Routes.usuarios_index_path(conn, :index))

      assert html =~ "Listing Usuarios"
      assert html =~ usuarios.nombre
    end

    test "saves new usuarios", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.usuarios_index_path(conn, :index))

      assert index_live |> element("a", "New Usuarios") |> render_click() =~
               "New Usuarios"

      assert_patch(index_live, Routes.usuarios_index_path(conn, :new))

      assert index_live
             |> form("#usuarios-form", usuarios: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#usuarios-form", usuarios: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.usuarios_index_path(conn, :index))

      assert html =~ "Usuarios created successfully"
      assert html =~ "some nombre"
    end

    test "updates usuarios in listing", %{conn: conn, usuarios: usuarios} do
      {:ok, index_live, _html} = live(conn, Routes.usuarios_index_path(conn, :index))

      assert index_live |> element("#usuarios-#{usuarios.id} a", "Edit") |> render_click() =~
               "Edit Usuarios"

      assert_patch(index_live, Routes.usuarios_index_path(conn, :edit, usuarios))

      assert index_live
             |> form("#usuarios-form", usuarios: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#usuarios-form", usuarios: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.usuarios_index_path(conn, :index))

      assert html =~ "Usuarios updated successfully"
      assert html =~ "some updated nombre"
    end

    test "deletes usuarios in listing", %{conn: conn, usuarios: usuarios} do
      {:ok, index_live, _html} = live(conn, Routes.usuarios_index_path(conn, :index))

      assert index_live |> element("#usuarios-#{usuarios.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#usuarios-#{usuarios.id}")
    end
  end

  describe "Show" do
    setup [:create_usuarios]

    test "displays usuarios", %{conn: conn, usuarios: usuarios} do
      {:ok, _show_live, html} = live(conn, Routes.usuarios_show_path(conn, :show, usuarios))

      assert html =~ "Show Usuarios"
      assert html =~ usuarios.nombre
    end

    test "updates usuarios within modal", %{conn: conn, usuarios: usuarios} do
      {:ok, show_live, _html} = live(conn, Routes.usuarios_show_path(conn, :show, usuarios))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Usuarios"

      assert_patch(show_live, Routes.usuarios_show_path(conn, :edit, usuarios))

      assert show_live
             |> form("#usuarios-form", usuarios: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#usuarios-form", usuarios: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.usuarios_show_path(conn, :show, usuarios))

      assert html =~ "Usuarios updated successfully"
      assert html =~ "some updated nombre"
    end
  end
end
