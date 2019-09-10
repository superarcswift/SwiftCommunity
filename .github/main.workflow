on: pull_request
name: UnitTest
jobs:
  test:
    name: UnitTest
    runs-on: macOS-latest
    strategy:
        matrix:
          destination: ['platform=iOS Simulator,OS=12.4,name=iPhone X']
    steps:
      - name: Checkout
        uses: actions/checkout@master
      - name: Build and test
        run: |
          xcodebuild clean test -workspace SwiftVideos.xcodeproj -scheme SwiftVideos -destination "${destination}" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO ONLY_ACTIVE_ARCH=NO
          bash <(curl -s https://codecov.io/bash)
        env:
         destination: ${{ matrix.destination }}
