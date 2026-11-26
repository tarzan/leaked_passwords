# Changelog

## 2.0.0 - 2026-11-26

### Breaking changes

- Requires Elixir 1.17 or later within the 1.x series and Erlang/OTP 27 or later.
- Upgrades the runtime HTTP client to HTTPoison 3 and Hackney 4. Applications
  that also depend on HTTPoison must use a compatible 3.x requirement.

### Maintenance

- Pins development to Elixir 1.20.5 and Erlang/OTP 29.1.3.
- Refreshes runtime and development dependencies, including the CA certificate bundle.
- Adds CI for Elixir 1.17.0 / OTP 27.3 and Elixir 1.20.5 / OTP 29.1.3.
- Links generated documentation to the release tag.

Password lookup return values and error-handling behavior are unchanged.
Pwned Passwords requests continue to use the unauthenticated hash-range API.
