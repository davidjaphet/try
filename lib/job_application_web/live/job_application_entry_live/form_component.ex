defmodule JobApplicationWeb.JobApplicationEntryLive.FormComponent do
  use JobApplicationWeb, :live_component

  alias JobApplication.Applications

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage job_application_entry records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="job_application_entry-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:full_name]} type="text" label="Full name" />
        <.input field={@form[:dob]} type="date" label="Dob" />
        <.input field={@form[:phone]} type="text" label="Phone" />
        <.input field={@form[:email]} type="text" label="Email" />
        <.input field={@form[:position]} type="text" label="Position" />
        <.input field={@form[:experience]} type="text" label="Experience" />
        <.input
          field={@form[:availability]}
          type="select"
          multiple
          label="Availability"
          options={[{"Option 1", "option1"}, {"Option 2", "option2"}]}
        />
        <.input field={@form[:background_check]} type="checkbox" label="Background check" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Job application entry</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{job_application_entry: job_application_entry} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Applications.change_job_application_entry(job_application_entry))
     end)}
  end

  @impl true
  def handle_event("validate", %{"job_application_entry" => job_application_entry_params}, socket) do
    changeset = Applications.change_job_application_entry(socket.assigns.job_application_entry, job_application_entry_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"job_application_entry" => job_application_entry_params}, socket) do
    save_job_application_entry(socket, socket.assigns.action, job_application_entry_params)
  end

  defp save_job_application_entry(socket, :edit, job_application_entry_params) do
    case Applications.update_job_application_entry(socket.assigns.job_application_entry, job_application_entry_params) do
      {:ok, job_application_entry} ->
        notify_parent({:saved, job_application_entry})

        {:noreply,
         socket
         |> put_flash(:info, "Job application entry updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_job_application_entry(socket, :new, job_application_entry_params) do
    case Applications.create_job_application_entry(job_application_entry_params) do
      {:ok, job_application_entry} ->
        notify_parent({:saved, job_application_entry})

        {:noreply,
         socket
         |> put_flash(:info, "Job application entry created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
