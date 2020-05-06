defmodule Drupal7PasswordHash do
  @moduledoc """
  Elixir implementation of drupal 7 compatible password hashing.

  ## NOTE

  The hashes are like drupal 7 hashes *except* they are prepended with the
  string `$drupal7`.
  """

  use Comeonin

  alias Drupal7PasswordHash.Base

  @doc """
  Hashes a password with a randomly generated salt.

  Only the SHA512 ("$S$") variant is supported.

  ## Options

  * `:log_rounds` - number of log rounds
    * the default is 15 (32768 rounds)
  """
  @impl true
  def hash_pwd_salt(password, opts \\ []) do
    Base.hash_pwd_salt(password, opts)
  end

  @doc """
  Verifies a password by hashing the password and comparing the hashed value
  with a stored hash.

  The SHA512 ("$S$") variant as well as both MD5 ("$H$", "$P$") variants are
  supported. The MD5 variants are untested, though.
  """
  @impl true
  def verify_pass(password, stored_hash) do
    ["drupal7", hash, encoded] = String.split(stored_hash, "$", trim: true)
    Base.verify_pass(password, hash, encoded)
  end
end
