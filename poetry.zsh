#!/usr/bin/env zsh
ZSH_POETRY_AUTO_ACTIVATE=${ZSH_POETRY_AUTO_ACTIVATE:-1}
ZSH_POETRY_AUTO_DEACTIVATE=${ZSH_POETRY_AUTO_DEACTIVATE:-1}
ZSH_POETRY_OVERRIDE_SHELL=${ZSH_POETRY_OVERRIDE_SHELL:-1}

autoload -U add-zsh-hook

_zp_current_project=

_zp_check_poetry_venv() {
  local venv
  if [[ -z $VIRTUAL_ENV ]] && [[ -n "${_zp_current_project}" ]]; then
    _zp_current_project=
  fi
  if [[ -f pyproject.toml ]] \
      && [[ "${PWD}" != "${_zp_current_project}" ]]; then
    venv="$(command poetry env list --full-path | sed "s/ .*//" | head -1)"
    if [[ -d "$venv" ]] && [[ "$venv" != "$VIRTUAL_ENV" ]]; then
      source "$venv"/bin/activate || return $?
      _zp_current_project="${PWD}"
      return 0
    fi
  elif [[ -n $VIRTUAL_ENV ]] \
      && [[ -n $ZSH_POETRY_AUTO_DEACTIVATE ]] \
      && [[ "${PWD}" != "${_zp_current_project}" ]] \
      && [[ "${PWD}" != "${_zp_current_project}"/* ]]; then
    deactivate
    _zp_current_project=
    return $?
  fi
  return 1
}
add-zsh-hook chpwd _zp_check_poetry_venv

poetry-shell() {
  _zp_check_poetry_venv
}

[[ -n $ZSH_POETRY_AUTO_ACTIVATE ]] && _zp_check_poetry_venv
