defmodule JobApplication.RecruitmentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `JobApplication.Recruitment` context.
  """

  @doc """
  Generate a application.
  """
  def application_fixture(attrs \\ %{}) do
    {:ok, application} =
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
      |> JobApplication.Recruitment.create_application()

    application
  end
end
