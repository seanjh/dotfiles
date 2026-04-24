#!/usr/bin/env bash

set -euo pipefail

models=(
  "qwen2.5-coder:7b"
  "gemma3:4b"
  "qwen3.5:4b"
  "deepseek-r1:14b"
)

for _ in {1..10}; do
  if ollama list >/dev/null 2>&1; then
    break
  fi
  sleep 2
done

if ! ollama list >/dev/null 2>&1; then
  printf 'Ollama is not available; skipping model pulls.\n' >&2
  exit 0
fi

for model in "${models[@]}"; do
  if ! ollama show "$model" >/dev/null 2>&1; then
    ollama pull "$model"
  fi
done
