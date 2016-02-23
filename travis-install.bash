set -ueo pipefail

KEY_CHAIN=ios-build.keychain

echo "find identity"
security find-identity

echo "create keychain"
security create-keychain -p travis $KEY_CHAIN

echo "default keychain"
security default-keychain -s $KEY_CHAIN

echo "unlock keychain"
security unlock-keychain -p travis $KEY_CHAIN

echo "set-keychain-settings"
security set-keychain-settings -t 3600 -u $KEY_CHAIN

