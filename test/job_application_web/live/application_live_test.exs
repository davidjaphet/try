defmodule JobApplicationWeb.ApplicationLiveTest do
  use JobApplicationWeb.ConnCase

  import Phoenix.LiveViewTest
  import JobApplication.RecruitmentFixtures

  @create_attrs %{availability: ["option1", "option2"], background_check: true, dob: "2025-02-18", email: "some email", experience: "some experience", full_name: "some full_name", phone: "some phone", position: "some position"}
  @update_attrs %{availability: ["option1"], background_check: false, dob: "2025-02-19", email: "some updated email", experience: "some updated experience", full_name: "some updated full_name", phone: "some updated phone", position: "some updated position"}
  @invalid_attrs %{availability: [], background_check: false, dob: nil, email: nil, experience: nil, full_name: nil, phone: nil, position: nil}

  defp create_application(_) do
    application = application_fixture()
    %{application: application}
  end

  describe "Index" do
    setup [:create_application]

    test "lists all job_applications", %{conn: conn, application: application} do
      {:ok, _index_live, html} = live(conn, ~p"/job_applications")

      assert html =~ "Listing Job applications"
      assert html =~ application.email
    end

    test "saves new application", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/job_applications")

      assert index_live |> element("a", "New Application") |> render_click() =~
               "New Application"

      assert_patch(index_live, ~p"/job_applications/new")

      assert index_live
             |> form("#application-form", application: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#application-form", application: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/job_applications")

      html = render(index_live)
      assert html =~ "Application created successfully"
      assert html =~ "some email"
    end

    test "updates application in listing", %{conn: conn, application: application} do
      {:ok, index_live, _html} = live(conn, ~p"/job_applications")

      assert index_live |> element("#job_applications-#{application.id} a", "Edit") |> render_click() =~
               "Edit Application"

      assert_patch(index_live, ~p"/job_applications/#{application}/edit")

      assert index_live
             |> form("#application-form", application: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#application-form", application: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/job_applications")

      html = render(index_live)
      assert html =~ "Application updated successfully"
      assert html =~ "some updated email"
    end

    test "deletes application in listing", %{conn: conn, application: application} do
      {:ok, index_live, _html} = live(conn, ~p"/job_applications")

      assert index_live |> element("#job_applications-#{application.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#job_applications-#{application.id}")
    end
  end

  describe "Show" do
    setup [:create_application]

    test "displays application", %{conn: conn, application: application} do
      {:ok, _show_live, html} = live(conn, ~p"/job_applications/#{application}")

      assert html =~ "Show Application"
      assert html =~ application.email
    end

    test "updates application within modal", %{conn: conn, application: application} do
      {:ok, show_live, _html} = live(conn, ~p"/job_applications/#{application}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Application"

      assert_patch(show_live, ~p"/job_applications/#{application}/show/edit")

      assert show_live
             |> form("#application-form", application: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#application-form", application: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/job_applications/#{application}")

      html = render(show_live)
      assert html =~ "Application updated successfully"
      assert html =~ "some updated email"
    end
  end
end
