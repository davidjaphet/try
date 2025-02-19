defmodule JobApplication.Applications.JobApplicationEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_applications" do
    field :availability, {:array, :string}
    field :background_check, :boolean, default: false
    field :dob, :date
    field :email, :string
    field :experience, :string
    field :full_name, :string
    field :phone, :string
    field :position, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(job_application_entry, attrs) do
    job_application_entry
    |> cast(attrs, [:full_name, :dob, :phone, :email, :position, :experience, :availability, :background_check])
    |> validate_required([:full_name, :dob, :phone, :email, :position, :experience, :availability, :background_check])
  end
end
