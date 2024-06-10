alias PlistBuddy=/usr/libexec/PlistBuddy

# Make a copy of a template
cp exportOptionsTemplate.plist exportOptionsTemplat_temp.plist

PLIST="exportOptionsTemplat_temp.plist"

# Config copy of template
PlistBuddy -c "set :destination export" $PLIST
PlistBuddy -c "set :method development" $PLIST
PlistBuddy -c "set :signingStyle manual" $PLIST
PlistBuddy -c "set :teamID D85QWSUNYA" $PLIST
PlistBuddy -c "set :signingCertificate iPhone Developer: Viktor Soviak (596GK6322F)" $PLIST
PlistBuddy -c "delete :provisioningProfiles:%BUNDLE_ID%" $PLIST
PlistBuddy -c "add :provisioningProfiles:ua.edu.ukma.apple-env.soviak.CatsAndModules-ViktorSoviak string 04af43ad-f9c1-4416-af6a-87a22d2283bf" $PLIST

# Read script input parameter and add it to your Info.plist. Values can either be CATS or DOGS
LOCAL_PLIST="CatsAndModules_ViktorSoviak/CatsAndModules-ViktorSoviak-Info.plist"
PlistBuddy -c "delete :Animal" $LOCAL_PLIST
PlistBuddy -c "add :Animal string $1" $LOCAL_PLIST

# Clean build folder
WORKSPACE=CatsAndModules_ViktorSoviak.xcworkspace # без пробілів!
SCHEME=CatsAndModules_ViktorSoviak
CONFIG=Debug # Release або Debug
DEST="generic/platform=iOS" # для експорту. Можна вказати platform, name (не generic)

xcodebuild clean -workspace "${WORKSPACE}" -scheme "${SCHEME}" -configuration "${CONFIG}"

# Create archive
VERSION="v1.0.0" # можна отримувати на вхід скрипту: VERSION $1
ARCHIVE_PATH="./ARCHIVES/${VERSION}.xcarchive"

# виконати збірку для конкретних параметрів
xcodebuild archive \
-archivePath "${ARCHIVE_PATH}" \
-workspace "${WORKSPACE}" \
-scheme "${SCHEME}" \
-configuration "${CONFIG}" \
-destination "${DEST}"

# Export archive
EXPORT_PATH="./Exported"

# виконати збірку для конкретних параметрів
xcodebuild -exportArchive \
-archivePath "${ARCHIVE_PATH}" \
-exportPath "${EXPORT_PATH}" \
-exportOptionsPlist "${PLIST}"

# Clean temp files
rm $PLIST
rm -rf ARCHIVES

echo "Completed!"