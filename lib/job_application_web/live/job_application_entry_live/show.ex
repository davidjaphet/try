defmodule JobApplicationWeb.JobApplicationEntryLive.Show do
  use JobApplicationWeb, :live_view

  alias JobApplication.Applications

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:job_application_entry, Applications.get_job_application_entry!(id))}
  end

  defp page_title(:show), do: "Show Job application entry"
  defp page_title(:edit), do: "Edit Job application entry"
end
