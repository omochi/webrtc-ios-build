#!/bin/bash
set -ueo pipefail
script_dir="$(cd "$(dirname "$0")"; pwd)"
mkdir -p webrtc-ios
cd webrtc-ios
touch .keep
fetch webrtc_ios

