defmodule JobApplication.ApplicationsTest do
  use JobApplication.DataCase

  alias JobApplication.Applications

  describe "job_applications" do
    alias JobApplication.Applications.JobApplicationEntry

    import JobApplication.ApplicationsFixtures

    @invalid_attrs %{availability: nil, background_check: nil, dob: nil, email: nil, experience: nil, full_name: nil, phone: nil, position: nil}

    test "list_job_applications/0 returns all job_applications" do
      job_application_entry = job_application_entry_fixture()
      assert Applications.list_job_applications() == [job_application_entry]
    end

    test "get_job_application_entry!/1 returns the job_application_entry with given id" do
      job_application_entry = job_application_entry_fixture()
      assert Applications.get_job_application_entry!(job_application_entry.id) == job_application_entry
    end

    test "create_job_application_entry/1 with valid data creates a job_application_entry" do
      valid_attrs = %{availability: ["option1", "option2"], background_check: true, dob: ~D[2025-02-18], email: "some email", experience: "some experience", full_name: "some full_name", phone: "some phone", position: "some position"}

      assert {:ok, %JobApplicationEntry{} = job_application_entry} = Applications.create_job_application_entry(valid_attrs)
      assert job_application_entry.availability == ["option1", "option2"]
      assert job_application_entry.background_check == true
      assert job_application_entry.dob == ~D[2025-02-18]
      assert job_application_entry.email == "some email"
      assert job_application_entry.experience == "some experience"
      assert job_application_entry.full_name == "some full_name"
      assert job_application_entry.phone == "some phone"
      assert job_application_entry.position == "some position"
    end

    test "create_job_application_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applications.create_job_application_entry(@invalid_attrs)
    end

    test "update_job_application_entry/2 with valid data updates the job_application_entry" do
      job_application_entry = job_application_entry_fixture()
      update_attrs = %{availability: ["option1"], background_check: false, dob: ~D[2025-02-19], email: "some updated email", experience: "some updated experience", full_name: "some updated full_name", phone: "some updated phone", position: "some updated position"}

      assert {:ok, %JobApplicationEntry{} = job_application_entry} = Applications.update_job_application_entry(job_application_entry, update_attrs)
      assert job_application_entry.availability == ["option1"]
      assert job_application_entry.background_check == false
      assert job_application_entry.dob == ~D[2025-02-19]
      assert job_application_entry.email == "some updated email"
      assert job_application_entry.experience == "some updated experience"
      assert job_application_entry.full_name == "some updated full_name"
      assert job_application_entry.phone == "some updated phone"
      assert job_application_entry.position == "some updated position"
    end

    test "update_job_application_entry/2 with invalid data returns error changeset" do
      job_application_entry = job_application_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Applications.update_job_application_entry(job_application_entry, @invalid_attrs)
      assert job_application_entry == Applications.get_job_application_entry!(job_application_entry.id)
    end

    test "delete_job_application_entry/1 deletes the job_application_entry" do
      job_application_entry = job_application_entry_fixture()
      assert {:ok, %JobApplicationEntry{}} = Applications.delete_job_application_entry(job_application_entry)
      assert_raise Ecto.NoResultsError, fn -> Applications.get_job_application_entry!(job_application_entry.id) end
    end

    test "change_job_application_entry/1 returns a job_application_entry changeset" do
      job_application_entry = job_application_entry_fixture()
      assert %Ecto.Changeset{} = Applications.change_job_application_entry(job_application_entry)
    end
  end
end
