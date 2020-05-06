defmodule Drupal7PasswordHash.Base do
  @moduledoc """
  Base module for the Drupal 7 compatible hashing library
  """

  alias Drupal7PasswordHash.Base64

  @hash_length 55 - 12

  defp gen_salt() do
    Base64.encode(:crypto.strong_rand_bytes(6))
  end

  defp hash(digest, password, salt, count) do
    case count do
      0 ->
        :crypto.hash(digest, salt <> password)
      count ->
        h = :crypto.hash(digest, salt <> password)
        hash(digest, password, h, count - 1)
    end
  end

  def hash_pwd_salt(password, opts) do
    count_log2 = Keyword.get(opts, :log_rounds, 15)
    count = Bitwise.bsl 1, count_log2
    salt = gen_salt()
    hash_encoded = Base64.encode(hash(:sha512, password, salt, count))
    settings = "$drupal7$S$" <> <<Base64.enc64(count_log2)>> <> salt
    settings <> binary_part(hash_encoded, 0, @hash_length)
  end

  def verify_pass(password, "S", encoded) do
    <<count_log2::8, salt::binary-size(8), hash_encoded::binary>> = encoded
    count = Bitwise.bsl 1, Base64.dec64(count_log2)
    h = hash(:sha512, password, salt, count)
    hash_encoded == binary_part(Base64.encode(h), 0, @hash_length)
  end

  def verify_pass(password, h, encoded) when h in ["H", "P"] do
    <<count_log2::8, salt::binary-size(8), hash_encoded::binary>> = encoded
    count = Bitwise.bsl 1, Base64.dec64(count_log2)
    h = hash(:md5, password, salt, count)
    hash_encoded == binary_part(Base64.encode(h), 0, @hash_length)
  end
end
