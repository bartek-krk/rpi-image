function log_error() {
  local RED='\033[0;31m'
  local NC='\033[0m'
  echo "${RED}[ERROR]${NC}   $1"
}

function log_info() {
  local BLUE='\033[0;34m'
  local NC='\033[0m'
  echo "${BLUE}[INFO]${NC}    $1"
}

function log_success() {
  local GREEN='\033[0;32m'
  local NC='\033[0m'
  echo "${GREEN}[SUCCESS]${NC} $1"
}

function log_warn() {
  local YELLOW='\033[1;33m'
  local NC='\033[0m'
  echo "${YELLOW}[WARN]${NC}    $1"
}

function print_waiting_msg() {
  while true
  do
    log_info "$1"
    sleep 0.5
  done
}

function panic() {
  log_error "Cannot proceed with script execution!!!"
  log_error "Unhandled error: $1"
  exit 1
}

function is_connected_to_internet() {
  print_waiting_msg "Checking Internet connection..." &
  local waiting_pid=$!

  ping -c 3 google.com > /dev/null 2>&1 &
  local ping_pid=$!

  wait $ping_pid
  local exit_cd=$?

  kill -9 $waiting_pid

  if [ "$exit_cd" -eq 0 ];
    then
      log_success "Connected to Internet"
      return 0
    else
      log_error "No Internet connection"
      return 1
  fi
}

function is_python_installed() {
  log_info "Checking if Python 3 is installed..."
    python3 --version > /dev/null
    local exit_cd=$?
    if [ $exit_cd -eq 0 ];
      then
        log_success "Python 3 already installed"
        return 0
      else
        log_error "Python 3 not installed"
        return 1
    fi
}