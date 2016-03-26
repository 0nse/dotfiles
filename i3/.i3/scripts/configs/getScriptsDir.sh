#!/bin/bash

resolveVariablesInString() {
  # Attention: Uses eval. Only call if you are aware of what you are passing.
  echo $(eval echo "${1}")
}

obtainLastEntry() {
  echo "${1}" | rev | cut -d ' ' -f 1 | rev
}

loadI3ConfigPath() {
  unresolvedPath=`sed -n 3p "${HOME}"/.configs`
  echo `resolveVariablesInString "${unresolvedPath}"`
}

loadScriptsDirPath() {
  i3ConfigPath="${1}"
  # the result is of form "set ${SCRIPTS_DIR} $HOME/scripts":
  unresolvedPath=`grep "set \\${SCRIPTS_DIR} " "${i3ConfigPath}"`
  i3ConfigEntry=`resolveVariablesInString "${unresolvedPath}"`
  echo `obtainLastEntry "${i3ConfigEntry}"`
}

i3ConfigPath=`loadI3ConfigPath`
loadScriptsDirPath "${i3ConfigPath}"
