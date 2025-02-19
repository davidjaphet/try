defmodule JobApplicationWeb.ApplicationLive.Index do
  use JobApplicationWeb, :live_view

  alias JobApplication.Recruitment
  alias JobApplication.Recruitment.Application

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :job_applications, Recruitment.list_job_applications())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Application")
    |> assign(:application, Recruitment.get_application!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Application")
    |> assign(:application, %Application{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Job applications")
    |> assign(:application, nil)
  end

  @impl true
  def handle_info({JobApplicationWeb.ApplicationLive.FormComponent, {:saved, application}}, socket) do
    {:noreply, stream_insert(socket, :job_applications, application)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    application = Recruitment.get_application!(id)
    {:ok, _} = Recruitment.delete_application(application)

    {:noreply, stream_delete(socket, :job_applications, application)}
  end
end
