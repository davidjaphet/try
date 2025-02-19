defmodule JobApplication.Repo.Migrations.CreateJobApplications do
  use Ecto.Migration

  def change do
    create table(:job_applications) do
      add :full_name, :string
      add :dob, :date
      add :phone, :string
      add :email, :string
      add :position, :string
      add :experience, :text
      add :availability, {:array, :string}
      add :background_check, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
