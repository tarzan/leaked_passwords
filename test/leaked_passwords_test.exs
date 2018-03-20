defmodule LeakedPasswordsTest do
  use ExUnit.Case
  doctest LeakedPasswords

  test "finds common passwords to be leaked" do
    assert LeakedPasswords.leaked?("my_password") == 896
  end

  test "does not find rare passwords to be leaked" do
    assert LeakedPasswords.leaked?("supa secret password zero five ow") == false
  end

  test "correctly hashes password with SHA1" do
    assert LeakedPasswords.hashed_password("my_password") ==
             String.upcase("5eb942810a75ebc850972a89285d570d484c89c4")
  end
end
