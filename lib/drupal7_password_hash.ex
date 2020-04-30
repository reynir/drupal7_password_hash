defmodule Drupal7PasswordHash do
  @moduledoc """
  Documentation for `Drupal7PasswordHash`.
  """

  use Comeonin

  alias Drupal7PasswordHash.Base

  @max_length Bitwise.bsl(1, 32) - 1

  @impl true
  def hash_pwd_salt(password, opts \\ []) do
    Base.hash_pwd_salt(password, opts)
  end

  @impl true
  def verify_pass(password, stored_hash) do
    ["drupal7", hash, encoded] = String.split(stored_hash, "$", trim: true)
    Base.verify_pass(password, hash, encoded)
  end
end
