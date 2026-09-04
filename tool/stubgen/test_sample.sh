#!/usr/bin/env bash
# Smoke test: parse representative exported files + run a full scan.
# Assumes CWD is the repo root (or wherever exported/ lives).
set -euo pipefail
cd "$(dirname "$0")/../.."

for f in \
  exported/TgGame/Classes/TgProj_Simulated.uc \
  exported/TgGame/Classes/TgRespawnBeaconExit.uc \
  exported/TgGame/Classes/TgAnimBlendBySkin.uc \
  exported/TgGame/Classes/TgDevice_AndroxusInhand.uc \
  exported/TgGame/Classes/Interface_AIAnnotation.uc \
  exported/TgClient/Classes/TgGameViewportClient.uc \
  exported/TgGame/Classes/None.uc \
  exported/Core/Classes/Object.uc ; do
  echo "== $f"
  python3 -m tool.stubgen parse "$f" >/dev/null || { echo "FAILED: $f"; exit 1; }
done

echo "== full scan"
python3 -m tool.stubgen scan >/dev/null || { echo "scan reported parse errors"; exit 1; }
echo "OK"
