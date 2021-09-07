defmodule CrudWeb.UsuariosLive.Index do
  use CrudWeb, :live_view

  alias Crud.Cuentas
  alias Crud.Cuentas.Usuarios

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :usuarios_collection, list_usuarios())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Usuarios")
    |> assign(:usuarios, Cuentas.get_usuarios!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Usuarios")
    |> assign(:usuarios, %Usuarios{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Usuarios")
    |> assign(:usuarios, %Usuarios{})
  end

  defp apply_action(socket, :search, _params) do
    socket
    |> assign(:page_title, "Search Usuarios")
    |> assign(:usuarios, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    usuarios = Cuentas.get_usuarios!(id)
    {:ok, _} = Cuentas.delete_usuarios(usuarios)

    {:noreply, assign(socket, :usuarios_collection, list_usuarios())}
  end

  defp list_usuarios do
    Cuentas.list_usuarios()
  end
end
