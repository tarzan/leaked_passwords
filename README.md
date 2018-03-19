# LeakedPasswords

**VERY BETA**

usage:
```ex
iex> LeakedPasswords.leaked?("my_password")
896

iex> LeakedPasswords.leaked?("my_super_safe_unknown_password")
false
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

