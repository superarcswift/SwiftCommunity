## SwiftVideos

[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/Swift-5.0-blue.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/Xcode-10-blue.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/platforms-iOSv|%20tvOS%20|%20macOS%20|%20watchOS%20-blue.svg)](https://opensource.org/licenses/MIT)

**Collection of Swift/iOS-related conference videos**.

This project serves as a showcase for **the SuperArc project (TSP)**. 

**TSP** aims to standardize many common building blocks which can help developers to kickstart new iOS projects quickly.

The goal is to have a set of modules to create a component-based MVVM-C (Model-View-ViewModel-Coordinator) architecture for iOS apps. The modules are intended to use together but each module should be able to be integrated into any other iOS projects. For more information about the SuperArc project, please take a look at [here](https://github.com/superarcswift/SwiftVideos).

## Content

All content are curated from external sources such as Vimeo, Youtube or WWDC live streams. This is insipred heavily from [SwiftTube](http://www.swifttube.co/) and [talk & coffe app](https://apps.apple.com/app/talks-coffee/id1466240063)

## App Features

- Data is stored in raw json files for easy integration with other tools.
- View a list of iOS/Swift related conferences.
- View a list of videos of conferences.
- View a list of speakers of conferences.
- Use git to manage the json database (Content is hosted at [SwiftVideosContent](https://github.com/superarcswift/SwiftVideosContent)).

## Technologies

### Tech-Stack

- Swift 5.0
- Xcode 10+
- 3rd Party Dependencies:
	- **SuperArc**: PromiseKit, RxSwift, Action, RxCocoa, NotificationBanner.
	- **SwiftVideos**: RxDataSources, XCoordinator, objective-git, YoutubeKit, MarkdownView.


### Tests

- [ ] Unit Tests
- [ ] UI Tests
- [ ] Snapshot Tests

### Package manager

- [ ] Carthage
- [ ] Swift Package Manager
- [ ] Pods

### Tools

- [ ] Swiftlint: [https://github.com/realm/SwiftLint](https://github.com/realm/SwiftLint)
- [ ] Danger: [https://danger.systems](https://danger.systems)
- [ ] Documentation: [https://github.com/realm/jazzy](https://github.com/realm/jazzy)
	
## Architecture

- [ ] µfeatures modules
- [ ] Clean architecture (at module level)

![Architecture](https://github.com/superarcswift/SwiftVideos/raw/master/Assets/Documentation/superarc.png)

### ViewModel

- Responsible for performing business logics.

### ViewController

- Responseible for interaction with users, displaying result from `ViewModel`.

### Component

- Responseible for managing dependencies required by its `ViewController` & `ViewModel`.
- Instantiate `ViewController`, `ViewModel`.

### Coordinator (optional)

- Responsible for navigation.
- Instantiate `Component`.


## Building and Running

## Authors

## Contributing

### Information
For convenience, all subprojects are kept in the same workspace & this reporistory so that we can iterate quickly without messing with versioning & package manager issues.

The goal for a stable version in the future is to have separated repositories for all components so that they can live independently from each others.

### Getting started

- Fork the repository.
- Run `carthage update --platform iOS`.
- Open the workspace in Xcode and you are good to go.
- Change code in any components you think it should be implemented differently.
- Commit the code changes to a separated branch in your cloned repository.
- Make a pull request to the upstream repository.

Open an issue if you want to discuss about the architecture, need help or request a new feature.

Open a PR if you want to make changes to any part of the frameworks.

## Inspiration

This project is very opinionated and probably not suitable for all kinds of iOS apps projects. I encourage you to take a look at other projects where you might find better architectures, approaches that are more suitable for your ideas:

- Open-Source iOS Apps: [https://github.com/dkhamsing/open-source-ios-apps](https://github.com/dkhamsing/open-source-ios-apps)
- The unofficial WWDC app for macOS:  [https://github.com/insidegui/WWDC](https://github.com/insidegui/WWDC)
- Conferences: [https://github.com/zagahr/Conferences.digital](https://github.com/zagahr/Conferences.digital)
- CocoaHub: [https://cocoahub.app/](https://cocoahub.app/)

## License

MIT License. See [LICENSE](https://github.com/superarcswift/SwiftVideos/blob/master/LICENSE)
