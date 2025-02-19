defmodule JobApplicationWeb.JobApplicationEntryLiveTest do
  use JobApplicationWeb.ConnCase

  import Phoenix.LiveViewTest
  import JobApplication.ApplicationsFixtures

  @create_attrs %{availability: ["option1", "option2"], background_check: true, dob: "2025-02-18", email: "some email", experience: "some experience", full_name: "some full_name", phone: "some phone", position: "some position"}
  @update_attrs %{availability: ["option1"], background_check: false, dob: "2025-02-19", email: "some updated email", experience: "some updated experience", full_name: "some updated full_name", phone: "some updated phone", position: "some updated position"}
  @invalid_attrs %{availability: [], background_check: false, dob: nil, email: nil, experience: nil, full_name: nil, phone: nil, position: nil}

  defp create_job_application_entry(_) do
    job_application_entry = job_application_entry_fixture()
    %{job_application_entry: job_application_entry}
  end

  describe "Index" do
    setup [:create_job_application_entry]

    test "lists all job_applications", %{conn: conn, job_application_entry: job_application_entry} do
      {:ok, _index_live, html} = live(conn, ~p"/job_applications")

      assert html =~ "Listing Job applications"
      assert html =~ job_application_entry.email
    end

    test "saves new job_application_entry", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/job_applications")

      assert index_live |> element("a", "New Job application entry") |> render_click() =~
               "New Job application entry"

      assert_patch(index_live, ~p"/job_applications/new")

      assert index_live
             |> form("#job_application_entry-form", job_application_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#job_application_entry-form", job_application_entry: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/job_applications")

      html = render(index_live)
      assert html =~ "Job application entry created successfully"
      assert html =~ "some email"
    end

    test "updates job_application_entry in listing", %{conn: conn, job_application_entry: job_application_entry} do
      {:ok, index_live, _html} = live(conn, ~p"/job_applications")

      assert index_live |> element("#job_applications-#{job_application_entry.id} a", "Edit") |> render_click() =~
               "Edit Job application entry"

      assert_patch(index_live, ~p"/job_applications/#{job_application_entry}/edit")

      assert index_live
             |> form("#job_application_entry-form", job_application_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#job_application_entry-form", job_application_entry: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/job_applications")

      html = render(index_live)
      assert html =~ "Job application entry updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes job_application_entry in listing", %{conn: conn, job_application_entry: job_application_entry} do
      {:ok, index_live, _html} = live(conn, ~p"/job_applications")

      assert index_live |> element("#job_applications-#{job_application_entry.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#job_applications-#{job_application_entry.id}")
    end
  end

  describe "Show" do
    setup [:create_job_application_entry]

    test "displays job_application_entry", %{conn: conn, job_application_entry: job_application_entry} do
      {:ok, _show_live, html} = live(conn, ~p"/job_applications/#{job_application_entry}")

      assert html =~ "Show Job application entry"
      assert html =~ job_application_entry.email
    end

    test "updates job_application_entry within modal", %{conn: conn, job_application_entry: job_application_entry} do
      {:ok, show_live, _html} = live(conn, ~p"/job_applications/#{job_application_entry}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Job application entry"

      assert_patch(show_live, ~p"/job_applications/#{job_application_entry}/show/edit")

      assert show_live
             |> form("#job_application_entry-form", job_application_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#job_application_entry-form", job_application_entry: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/job_applications/#{job_application_entry}")

      html = render(show_live)
      assert html =~ "Job application entry updated successfully"
      assert html =~ "some updated email"
    end
  end
end
