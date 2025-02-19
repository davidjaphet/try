defmodule JobApplication.ApplicationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JobApplication.Applications` context.
  """

  @doc """
  Generate a job_application_entry.
  """
  def job_application_entry_fixture(attrs \\ %{}) do
    {:ok, job_application_entry} =
      attrs
      |> Enum.into(%{
        availability: ["option1", "option2"],
        background_check: true,
        dob: ~D[2025-02-18],
        email: "some email",
        experience: "some experience",
        full_name: "some full_name",
        phone: "some phone",
        position: "some position"
      })
      |> JobApplication.Applications.create_job_application_entry()

    job_application_entry
  end
end
