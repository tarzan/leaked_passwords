# LeakedPasswords

[![Module Version](https://img.shields.io/hexpm/v/leaked_passwords.svg)](https://hex.pm/packages/leaked_passwords)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/leaked_passwords/)
[![Total Download](https://img.shields.io/hexpm/dt/leaked_passwords.svg)](https://hex.pm/packages/leaked_passwords)
[![License](https://img.shields.io/hexpm/l/leaked_passwords.svg)](https://github.com/tarzan/leaked_passwords/blob/master/LICENSE)
[![Last Updated](https://img.shields.io/github/last-commit/tarzan/leaked_passwords.svg)](https://github.com/tarzan/leaked_passwords/commits/master)

A wrapper around [Have I Been Pwned?](https://haveibeenpwned.com/) API endpoints for checking through its datasets whether a given password has been leaked. This wrapper uses the 'safe' endpoints by first calculating the SHA1 and then only POSTing the first 5 characters to the API endpoints.

---

## Usage

```elixir
iex> LeakedPasswords.leaked?("my_password")
896

iex> LeakedPasswords.leaked?("my_super_safe_unknown_password")
false
```

_Within Changesets_

```elixir
  defp check_for_leaked_password(%Changeset{changes: %{set_password: password}} = changeset) do
    password
    |> LeakedPasswords.leaked?()
    |> process_leaked_check(changeset)
  end

  defp check_for_leaked_password(changeset), do: changeset

  defp process_leaked_check(false, changeset), do: changeset

  defp process_leaked_check(_, changeset),
    do:
      add_error(
        changeset,
        :set_password, #virtual password field
        dgettext(
          "errors",
          "The chosen password must not match %{link_start}this list of common passwords%{link_end}.",
          link_start:
            "<a href=\"https://haveibeenpwned.com/passwords\" target=\"_blank\" rel=\"noopener noreferrer\">",
          link_end: "</a>"
        ),
        error_type: :leaked_password
      )
```

## Installation

The package can be installed by adding `:leaked_passwords` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:leaked_passwords, "~> 1.0"}
  ]
end
```

## Copyright and License

Copyright (c) 2018 Maarten Jacobs

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE.md](./LICENSE.md) file for more details.
