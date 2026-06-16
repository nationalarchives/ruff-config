<img src="https://raw.githubusercontent.com/nationalarchives/tna-frontend/main/src/nationalarchives/assets/images/tna-square-logo.svg" alt="The National Archives logo" title="The National Archives" width="100" />

# The National Archives Ruff config

[![Latest release](https://img.shields.io/github/v/release/nationalarchives/ruff-config?style=flat-square&logo=github&logoColor=white&sort=semver)](https://github.com/nationalarchives/ruff-config/releases)
[![PyPi version](https://img.shields.io/pypi/v/tna-ruff-config?style=flat-square&logo=pypi&logoColor=white)](https://pypi.org/project/tna-ruff-config/)
[![Licence](https://img.shields.io/github/license/nationalarchives/ruff-config?style=flat-square)](https://github.com/nationalarchives/ruff-config/blob/main/LICENCE)

These configurations are included in the [`tna-python-dev` Docker image](https://github.com/nationalarchives/docker/tree/main/docker/tna-python-dev#format) as part of the `format` command.

Two Ruff configurations are available:

- [`ruff.toml`](#standard-configuration) - a general purpose Ruff configuration
- [`ruff-strict.toml`](#strict-configuration) - a configuration with a stricter set of rules

## Standard configuration

The standard configuration [`ruff.toml`](./tna_ruff_config/ruff.toml) includes the following rules:

| Rule             | Purpose                                                                         | Defined by                                                               |
| ---------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------ |
| `E4`, `E7`, `E9` | [Subset of pycodestyle errors](https://pypi.org/project/pycodestyle/)           | [Ruff default configuration](https://docs.astral.sh/ruff/configuration/) |
| `F`              | [Pyflakes](https://pypi.org/project/pyflakes/)                                  | [Ruff default configuration](https://docs.astral.sh/ruff/configuration/) |
| `W`              | [pycodestyle warnings](https://pypi.org/project/pycodestyle/)                   | [`ruff.toml`](./tna_ruff_config/ruff.toml)                                 |
| `C901`           | [mccabe "Function is too complex"](https://www.flake8rules.com/rules/C901.html) | [`ruff.toml`](./tna_ruff_config/ruff.toml)                                 |
| `B`              | [flake8-bugbear](https://pypi.org/project/flake8-bugbear/)                      | [`ruff.toml`](./tna_ruff_config/ruff.toml)                                 |
| `I`              | [isort](https://pypi.org/project/isort/)                                        | [`ruff.toml`](./tna_ruff_config/ruff.toml)                                 |

### Ignores

Certain rules are ignored for `__init__.py` files:

- `E402` (module-import-not-at-top-of-file) and `PLC0415` (import-outside-top-level) - some imports like in Django settings files are added later on in the file, sometimes under conditionals
- `F401` (unused-import) - imports don't have to be used in module files which also helps with Django settings

## Strict configuration

Extra rules are included in [`ruff-strict.toml`](./tna_ruff_config/ruff-strict.toml). You can find more information on each of the rules in the [Ruff rules documentation](https://docs.astral.sh/ruff/rules/).

## Using from PyPI

```bash
# Install with Poetry
poetry add tna-ruff-config
TNA_RUFF_CONFIG_DIRECTORY="$(poetry run python -c 'from sysconfig import get_path; print(get_path("platlib"))')/tna_ruff_config"

# ...or pip
pip install tna-ruff-config
TNA_RUFF_CONFIG_DIRECTORY="$(python -c 'from sysconfig import get_path; print(get_path("platlib"))')/tna_ruff_config"

# Run Ruff check using the standard config
ruff check /app --fix --config "$TNA_RUFF_CONFIG_DIRECTORY/ruff.toml"
# Run the Ruff formatter using the standard config
ruff format /app --config "$TNA_RUFF_CONFIG_DIRECTORY/ruff.toml"
```
