defmodule CrudWeb.UsuariosLive.Search do
  use CrudWeb, :live_view

  alias Crud.Cuentas
  alias Crud.Cuentas.Usuarios

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
      usuario: "",
      usuarios_collection: [],
      loading: false,
      consultado: false)
      {:ok, socket}
  end

  defp list_usuarios do
    Cuentas.list_usuarios()
  end


  def handle_event("usuario-search", %{"usuario" => usuario}, socket) do
    send(self(), {:run_usuario_search, usuario})

    socket =
      assign(socket,
        usuario: usuario,
        usuarios_collection: Cuentas.search_by_usuario(usuario),
        loading: true,
        consultado: true
      )

    {:noreply, socket}
  end

  def handle_info({:run_usuario_search, usuario}, socket) do

    case Cuentas.search_by_usuario(usuario) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No hay coincidencias para el usuario \"#{usuario}\"")
          |> assign(usuarios_collection: [], loading: false, consultado: false)

        {:noreply, socket}

      usuarios ->
        socket = assign(socket, usuarios: usuarios, loading: false, consultado: true)
        {:noreply, socket}
    end
  end

end
