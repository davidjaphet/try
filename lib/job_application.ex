defmodule JobApplication.Applications.JobApplication do
  use Ecto.Schema
  import Ecto.Changeset

  schema "job_applications" do
    field :full_name, :string
    field :dob, :date
    field :phone, :string
    field :email, :string
    field :position, :string
    field :experience, :string
    field :availability, {:array, :string}
    field :background_check, :boolean

    timestamps()
  end

  def changeset(job_application, attrs) do
    job_application
    |> cast(attrs, [:full_name, :dob, :phone, :email, :position, :experience, :availability, :background_check])
    |> validate_required([:full_name, :dob, :phone, :email, :position])
  end
end
