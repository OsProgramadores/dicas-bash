# Adicione esse arquivo ao seu arquivo ~/.bashrc
# 2019 by Marco Paganini (paganini@paganini.net)

# Atributos (cores) comuns.
if [ -n "$TERM" ]; then
  export _TERM_FG_RED=$(tput setaf 1)
  export _TERM_FG_GREEN=$(tput setaf 2)
  export _TERM_FG_YELLOW=$(tput setaf 3)
  export _TERM_FG_BLUE=$(tput setaf 4)
  export _TERM_FG_MAGENTA=$(tput setaf 5)
  export _TERM_FG_CYAN=$(tput setaf 6)
  export _TERM_FG_WHITE=$(tput setaf 7)
  export _TERM_BG_RED=$(tput setab 1)
  export _TERM_BG_GREEN=$(tput setab 2)
  export _TERM_BG_YELLOW=$(tput setab 3)
  export _TERM_BG_BLUE=$(tput setab 4)
  export _TERM_BG_MAGENTA=$(tput setab 5)
  export _TERM_BG_CYAN=$(tput setab 6)
  export _TERM_BG_WHITE=$(tput setab 7)
  export _TERM_BOLD=$(tput bold)
  export _TERM_REVERSE=$(tput smso)
  export _TERM_RESET=$(tput sgr0)
fi

# Cores para partes específicas do prompt.
GIT_BRANCH_COLOR="${_TERM_BOLD}${_TERM_FG_GREEN}"
ROOT_COLOR="${_TERM_FG_WHITE}${_TERM_BG_RED}"
HOST_COLOR="${_TERM_FG_BLUE}"
DIR_COLOR="${_TERM_FG_CYAN}"

function format_cwd() {
  local cwd=$(pwd)
  cwd=${cwd/#$HOME/\~}
  echo $cwd
}

# Git branch formatado -- otimizado para velocidade.
function format_git_branch() {
  local cwd=$(pwd)
  local branches=$(git branch --no-color 2>/dev/null)
  if [ -n "$branches" ]; then
    branch_name=$(echo "$branches" | sed -ne 's/^\* \(.*\)/\1/p')
    echo "«${GIT_BRANCH_COLOR}${branch_name}${_TERM_RESET}» "
  fi
}

# Mostra o numero de jobs pendentes.
function format_num_jobs() {
  local out=$(jobs -p)
  if [[ -n "$out" ]]; then
    echo "${_TERM_BOLD}[$(echo $out | wc -w)]${_TERM_RESET} "
  fi
}

# Prompt
host_color="$HOST_COLOR"
if [ -n "$I_AM_ROOT" ]; then
  host_color="$ROOT_COLOR"
fi

export PS1="\$(format_num_jobs)\$(format_git_branch)"
PS1="${PS1}${_TERM_BOLD}$host_color\u@${HOST_COLOR}\h${_TERM_RESET}:"
PS1="${PS1}${_TERM_BOLD}$DIR_COLOR\w${_TERM_RESET}\n\\$ "
