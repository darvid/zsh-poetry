[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)
![ZSH 5.0.2+](https://img.shields.io/badge/zsh-v5.0.2-orange.svg)

# zsh-poetry
Automatically activates virtual environments created by [Poetry] when
changing to a project directory with a valid ``pyproject.toml``.

Also patches ``poetry shell`` to work more reliably, especially in
environments using [pyenv]. See [sdispater/poetry#571][i571] and
[sdispater/poetry#497][i497] for more information.

[Poetry]: https://poetry.eustace.io/
[pyenv]: https://github.com/pyenv/pyenv
[i571]: https://github.com/sdispater/poetry/issues/571
[i497]: https://github.com/sdispater/poetry/issues/497


## Install
Download and `source poetry.zsh`.

### Antigen
`antigen bundle darvid/zsh-poetry`

### zplug
`zplug "darvid/zsh-poetry"`


## Configuration

**Options:**
* `ZSH_POETRY_AUTO_ACTIVATE` (default: `1`): if set, automatically
  activates virtual environments in valid project directories when
  changing directories.
* `ZSH_POETRY_AUTO_DEACTIVATE` (default: `1`): if set, automatically
  deactivates virtual environments when moving out of project directories.
* `ZSH_POETRY_OVERRIDE_SHELL` (default: `1`): if set, replaces
  ``poetry shell`` with a call to activate the virtualenv directly,
  which circumvents Poetry's (currently) problematic behavior when trying
  to activate a shell in some environments.
