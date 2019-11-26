#!/bin/sh

xcodebuild test \
    -workspace SwiftCommunity.xcworkspace \
    -scheme SwiftCommunityUITests \
    -configuration DEBUG \
    -destination "platform=iOS Simulator,name=iPhone 11" \
    -derivedDataPath ./build/DerivedData
