call_trace() {
  local frame=0
  while caller $frame; do
    ((frame++));
  done
  echo "$*"

  return 0
}

die() {
  call_trace
  exit 1
}

export -f call_trace die
