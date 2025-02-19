defmodule JobApplication.RecruitmentTest do
  use JobApplication.DataCase

  alias JobApplication.Recruitment

  describe "job_applications" do
    alias JobApplication.Recruitment.Application

    import JobApplication.RecruitmentFixtures

    @invalid_attrs %{availability: nil, background_check: nil, dob: nil, email: nil, experience: nil, full_name: nil, phone: nil, position: nil}

    test "list_job_applications/0 returns all job_applications" do
      application = application_fixture()
      assert Recruitment.list_job_applications() == [application]
    end

    test "get_application!/1 returns the application with given id" do
      application = application_fixture()
      assert Recruitment.get_application!(application.id) == application
    end

    test "create_application/1 with valid data creates a application" do
      valid_attrs = %{availability: ["option1", "option2"], background_check: true, dob: ~D[2025-02-18], email: "some email", experience: "some experience", full_name: "some full_name", phone: "some phone", position: "some position"}

      assert {:ok, %Application{} = application} = Recruitment.create_application(valid_attrs)
      assert application.availability == ["option1", "option2"]
      assert application.background_check == true
      assert application.dob == ~D[2025-02-18]
      assert application.email == "some email"
      assert application.experience == "some experience"
      assert application.full_name == "some full_name"
      assert application.phone == "some phone"
      assert application.position == "some position"
    end

    test "create_application/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recruitment.create_application(@invalid_attrs)
    end

    test "update_application/2 with valid data updates the application" do
      application = application_fixture()
      update_attrs = %{availability: ["option1"], background_check: false, dob: ~D[2025-02-19], email: "some updated email", experience: "some updated experience", full_name: "some updated full_name", phone: "some updated phone", position: "some updated position"}

      assert {:ok, %Application{} = application} = Recruitment.update_application(application, update_attrs)
      assert application.availability == ["option1"]
      assert application.background_check == false
      assert application.dob == ~D[2025-02-19]
      assert application.email == "some updated email"
      assert application.experience == "some updated experience"
      assert application.full_name == "some updated full_name"
      assert application.phone == "some updated phone"
      assert application.position == "some updated position"
    end

    test "update_application/2 with invalid data returns error changeset" do
      application = application_fixture()
      assert {:error, %Ecto.Changeset{}} = Recruitment.update_application(application, @invalid_attrs)
      assert application == Recruitment.get_application!(application.id)
    end

    test "delete_application/1 deletes the application" do
      application = application_fixture()
      assert {:ok, %Application{}} = Recruitment.delete_application(application)
      assert_raise Ecto.NoResultsError, fn -> Recruitment.get_application!(application.id) end
    end

    test "change_application/1 returns a application changeset" do
      application = application_fixture()
      assert %Ecto.Changeset{} = Recruitment.change_application(application)
    end
  end
end
