defmodule Drupal7PasswordHash.Base64 do
  @moduledoc """
  Base64 encoding for Drupal 7 compatible password hashes.

  You should probably not use this module directly.
  """

  import Bitwise

  itoa64 =
    Enum.with_index('./0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz')
  for {encoding, value} <- itoa64 do
    def unquote(:enc64)(unquote(value)), do: unquote(encoding)
    def unquote(:dec64)(unquote(encoding)), do: unquote(value)
  end

  defp do_encode(<<>>, acc), do: acc
  defp do_encode(<<c2::2, c1::6>>, acc) do
    <<acc::binary, enc64(c1)::8, enc64(c2)::8>>
  end
  defp do_encode(<<c2_1::2, c1::6, c3::4, c2_2::4>>, acc) do
    c2 = bor(c2_1, bsl(c2_2, 2))
    <<acc::binary, enc64(c1)::8, enc64(c2)::8, enc64(c3)::8>>
  end
  defp do_encode(<<c2_1::2, c1::6, c3_1::4, c2_2::4, c4::6, c3_2::2, rest::binary>>, acc) do
    c2 = bor(c2_1, bsl(c2_2, 2))
    c3 = bor(c3_1, bsl(c3_2, 4))
    do_encode(rest, <<acc::binary, enc64(c1)::8, enc64(c2)::8, enc64(c3)::8, enc64(c4)>>)
  end


  def encode(data), do: do_encode(data, <<>>)

end
