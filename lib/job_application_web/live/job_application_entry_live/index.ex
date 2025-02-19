defmodule JobApplicationWeb.JobApplicationLive.Index do
  use JobApplicationWeb, :live_view

  def render(assigns) do
    ~L"""
    <h1>Job Application</h1>
    <form phx-submit="submit_application">
      <label for="full_name">Full Name</label>
      <input type="text" name="full_name" id="full_name" required />

      <label for="dob">Date of Birth</label>
      <input type="date" name="dob" id="dob" required />

      <label for="phone">Phone</label>
      <input type="text" name="phone" id="phone" required />

      <label for="email">Email</label>
      <input type="email" name="email" id="email" required />

      <label for="position">Position</label>
      <input type="text" name="position" id="position" required />

      <label for="experience">Experience</label>
      <textarea name="experience" id="experience" required></textarea>

      <label for="availability">Availability</label>
      <input type="text" name="availability" id="availability" required />

      <label for="background_check">Background Check</label>
      <input type="checkbox" name="background_check" id="background_check" />

      <button type="submit">Submit</button>
    </form>
    """
  end

  def handle_event("submit_application", %{"full_name" => full_name, "dob" => dob, "phone" => phone, "email" => email, "position" => position, "experience" => experience, "availability" => availability, "background_check" => background_check}, socket) do
    IO.inspect(%{
      full_name: full_name,
      dob: dob,
      phone: phone,
      email: email,
      position: position,
      experience: experience,
      availability: availability,
      background_check: background_check
    })

    {:noreply, socket}
  end
end
