defmodule CrudWeb.LiveHelpers do
  import Phoenix.LiveView.Helpers

  @doc """
  Renders a component inside the `CrudWeb.ModalComponent` component.

  The rendered modal receives a `:return_to` option to properly update
  the URL when the modal is closed.

  ## Examples

      <%= live_modal @socket, CrudWeb.UsuariosLive.FormComponent,
        id: @usuarios.id || :new,
        action: @live_action,
        usuarios: @usuarios,
        return_to: Routes.usuarios_index_path(@socket, :index) %>
  """
  def live_modal(socket, component, opts) do
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = [id: :modal, return_to: path, component: component, opts: opts]
    live_component(socket, CrudWeb.ModalComponent, modal_opts)
  end
end
