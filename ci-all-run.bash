repo_top_dir="$(pwd)"
cd "$repo_top_dir"

git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git "$HOME/depot_tools"
export PATH="$PATH:$HOME/depot_tools"

mkdir -p webrtc_ios
cd webrtc_ios
touch .keep
fetch --nohooks webrtc_ios
cd src
git checkout ba3e25e50296518cccca4732b769e698dfc03365
gclient sync

cd "$repo_top_dir"
./webrtc-ios-build.rb


