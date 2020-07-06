# LeakedPasswords

A wrapper around [Have I Been Pwned?](https://haveibeenpwned.com/) API endpoints for checking through its datasets whether a given password has been leaked. This wrapper uses the 'safe' endpoints by first calculating the SHA1 and then only POSTing the first 5 characters to the API endpoints.

---

## Usage

```ex
iex> LeakedPasswords.leaked?("my_password")
896

iex> LeakedPasswords.leaked?("my_super_safe_unknown_password")
false
```

_Within Changesets_
```ex
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
        :set_password, #virtual passowrd field
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

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `leaked_passwords` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:leaked_passwords, git: "https://github.com/tarzan/leaked_passwords.git"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/leaked_passwords](https://hexdocs.pm/leaked_passwords).

