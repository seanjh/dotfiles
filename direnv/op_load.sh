# Load secrets from 1Password into the environment.
# Usage: op_load \
#   KEY="op://vault/item/field" \
#   OTHER_KEY="op://vault/item with spaces/field name"
op_load() {
  for arg in "$@"; do
    export "${arg%%=*}=$(op read "${arg#*=}")"
  done
}
