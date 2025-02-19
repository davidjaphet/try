defmodule JobApplication.Applications do
  @moduledoc """
  The Applications context.
  """

  import Ecto.Query, warn: false
  alias JobApplication.Repo

  alias JobApplication.Applications.JobApplicationEntry

  @doc """
  Returns the list of job_applications.

  ## Examples

      iex> list_job_applications()
      [%JobApplicationEntry{}, ...]

  """
  def list_job_applications do
    Repo.all(JobApplicationEntry)
  end

  @doc """
  Gets a single job_application_entry.

  Raises `Ecto.NoResultsError` if the Job application entry does not exist.

  ## Examples

      iex> get_job_application_entry!(123)
      %JobApplicationEntry{}

      iex> get_job_application_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_job_application_entry!(id), do: Repo.get!(JobApplicationEntry, id)

  @doc """
  Creates a job_application_entry.

  ## Examples

      iex> create_job_application_entry(%{field: value})
      {:ok, %JobApplicationEntry{}}

      iex> create_job_application_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_job_application_entry(attrs \\ %{}) do
    %JobApplicationEntry{}
    |> JobApplicationEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a job_application_entry.

  ## Examples

      iex> update_job_application_entry(job_application_entry, %{field: new_value})
      {:ok, %JobApplicationEntry{}}

      iex> update_job_application_entry(job_application_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_job_application_entry(%JobApplicationEntry{} = job_application_entry, attrs) do
    job_application_entry
    |> JobApplicationEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a job_application_entry.

  ## Examples

      iex> delete_job_application_entry(job_application_entry)
      {:ok, %JobApplicationEntry{}}

      iex> delete_job_application_entry(job_application_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_job_application_entry(%JobApplicationEntry{} = job_application_entry) do
    Repo.delete(job_application_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking job_application_entry changes.

  ## Examples

      iex> change_job_application_entry(job_application_entry)
      %Ecto.Changeset{data: %JobApplicationEntry{}}

  """
  def change_job_application_entry(%JobApplicationEntry{} = job_application_entry, attrs \\ %{}) do
    JobApplicationEntry.changeset(job_application_entry, attrs)
  end
end
