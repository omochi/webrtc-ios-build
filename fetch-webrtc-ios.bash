#!/bin/bash
set -ueo pipefail
script_dir="$(cd "$(dirname "$0")"; pwd)"
mkdir -p webrtc_ios
cd webrtc_ios
touch .keep
fetch webrtc_ios

