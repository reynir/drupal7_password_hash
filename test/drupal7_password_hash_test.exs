defmodule Drupal7PasswordHashTest do
  use ExUnit.Case
  doctest Drupal7PasswordHash

  import Comeonin.BehaviourTestHelper
  
  test "Verifying password against fixed hash" do
    password = "testtest"
    hash = "$drupal7$S$D........kQC5tK6NKvmBsGYVu/RhwJohxyWkPSk5UhgzwJDXP5f"
    Drupal7PasswordHash.verify_pass(password, hash)
  end

    test "implementation of Comeonin.PasswordHash behaviour" do
    password = Enum.random(ascii_passwords())
    assert correct_password_true(Drupal7PasswordHash, password)
    assert wrong_password_false(Drupal7PasswordHash, password)
  end

  test "Comeonin.PasswordHash behaviour with non-ascii characters" do
    password = Enum.random(non_ascii_passwords())
    assert correct_password_true(Drupal7PasswordHash, password)
    assert wrong_password_false(Drupal7PasswordHash, password)
  end

  test "add_hash function" do
    password = Enum.random(ascii_passwords())
    assert add_hash_creates_map(Drupal7PasswordHash, password)
  end

  test "check_pass function" do
    password = Enum.random(ascii_passwords())
    assert check_pass_returns_user(Drupal7PasswordHash, password)
    assert check_pass_returns_error(Drupal7PasswordHash, password)
    assert check_pass_nil_user(Drupal7PasswordHash)
  end

end
