defmodule CrudWeb.UsuariosLive.FormComponent do
  use CrudWeb, :live_component

  alias Crud.Cuentas

  @impl true
  def update(%{usuarios: usuarios} = assigns, socket) do
    changeset = Cuentas.change_usuarios(usuarios)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"usuarios" => usuarios_params}, socket) do
    changeset =
      socket.assigns.usuarios
      |> Cuentas.change_usuarios(usuarios_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"usuarios" => usuarios_params}, socket) do
    save_usuarios(socket, socket.assigns.action, usuarios_params)
  end

  defp save_usuarios(socket, :edit, usuarios_params) do
    case Cuentas.update_usuarios(socket.assigns.usuarios, usuarios_params) do
      {:ok, _usuarios} ->
        {:noreply,
         socket
         |> put_flash(:info, "Usuarios actualizados correctamente!")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_usuarios(socket, :new, usuarios_params) do
    case Cuentas.create_usuarios(usuarios_params) do
      {:ok, _usuarios} ->
        {:noreply,
         socket
         |> put_flash(:info, "La cuenta ha sido creada")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
