defmodule DataGenerator do
  @moduledoc """
  Generate a list of random unsigned 8-bit integers (bytes).
  """

  @doc """
  Return a list of `count` random bytes in the range 0..255.
  """
  def generate_bytes(count) when is_integer(count) and count > 0 do
    :rand.seed(:exsp, {1234, 5678, 9012})
    for _ <- 1..count, do: :rand.uniform(256) - 1
  end
end

defmodule Adler32Checksum do
  @moduledoc """
  Compute the Adler-32 checksum for a list of bytes.

  The algorithm:
  - Initialize A = 1, B = 0.
  - For each byte, A = (A + byte) mod 65521, B = (B + A) mod 65521.
  - Final checksum = (B << 16) | A.
  """

  @doc """
  Compute the Adler-32 checksum of the given list of bytes.
  """
  def compute(byte_list) when is_list(byte_list) do
    {a, b} =
      Enum.reduce(byte_list, {1, 0}, fn byte, {a_acc, b_acc} ->
        a_new = rem(a_acc + byte, 65_521)
        b_new = rem(b_acc + a_new, 65_521)
        {a_new, b_new}
      end)

    (b <<< 16) + a
  end
end

# === Main Program ===

count = 50_000_000
IO.puts("Generating list of #{count} random bytes...")

byte_list = DataGenerator.generate_bytes(count)

IO.puts("Computing Adler-32 checksum...")

checksum = Adler32Checksum.compute(byte_list)

IO.puts("Adler-32 Checksum = #{checksum}")

