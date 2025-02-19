defmodule JobApplicationWeb.JobApplicationLive do
  use JobApplicationWeb, :live_view
  alias JobApplication.Applications
  alias JobApplication.Applications.JobApplication

  def mount(_params, _session, socket) do
    changeset = Applications.change_job_application(%JobApplication{})
    {:ok, assign(socket, changeset: changeset)}
  end

  def handle_event("validate", %{"job_application" => job_params}, socket) do
    changeset =
      Applications.change_job_application(%JobApplication{}, job_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", %{"job_application" => job_params}, socket) do
    case Applications.create_job_application(job_params) do
      {:ok, _job_application} ->
        {:noreply, socket |> put_flash(:info, "Application submitted!") |> push_patch(to: "/")}
      {:error, changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
