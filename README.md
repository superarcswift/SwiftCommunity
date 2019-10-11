## SwiftCommunity

[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/Swift-5.0-blue.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/Xcode-10-blue.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/platforms-iOSv|%20tvOS%20|%20macOS%20|%20watchOS%20-blue.svg)](https://opensource.org/licenses/MIT)

**Collection of Swift/iOS-related conference videos**.

This project serves as a showcase for **the SuperArc project (TSP)**. 

**TSP** aims to standardize many common building blocks which can help developers to kickstart new iOS projects quickly.

The goal is to have a set of modules to create a component-based MVVM-C (Model-View-ViewModel-Coordinator) architecture for iOS apps. The modules are intended to use together but each module should be able to be integrated into any other iOS projects. This setup is incredibly useful when you create multiple apps which share some same features/functionalities. For more information about the SuperArc project, please take a look at [here](https://github.com/superarcswift/SwiftCommunity).

## Content

All content are curated from external sources such as Vimeo, Youtube or WWDC live streams. This is insipred heavily from [SwiftTube](http://www.swifttube.co/) and [talk & coffe app](https://apps.apple.com/app/talks-coffee/id1466240063)

## App Features

- Data is stored in raw json files for easy integration with other tools.
- View a list of iOS/Swift related conferences.
- View a list of videos of conferences.
- View a list of speakers of conferences.
- Use git to manage the json database (Content is hosted at [SwiftCommunityContent](https://github.com/superarcswift/SwiftCommunityContent)).

## Technologies

### Tech-Stack

- Swift 5.0
- Xcode 10+
- 3rd Party Dependencies:
	- **SuperArc**: PromiseKit, RxSwift, Action, RxCocoa, NotificationBanner, Kingfisher.
	- **SwiftCommunity**: RxDataSources, XCoordinator, objective-git, YoutubeKit, LXVimeoKit, MarkdownView.


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

When building an iOS app, developers normally starts with a single workspace/project which contains all source codes of the app. This setup is useful for smaller apps, but when the app grows, there are some problem comming with this setup:

- Implicit dependencies between classes: because all classes living in the same module, they can access each other easily.
- Slow compilation time since all source codes will be complied everytime.
- Hard to reuse code because strong coupling between classes.
- Hard to scale and maintain because of complex dependencies between classes.

**TSP** proposes a different approach to modularise the app architecture into foundation and feature modules

- [ ] **foundation modules**: used by other **feature modules**, providing tools and utilities to develop **feature modules**.
- [ ] **feature modules**: built using **foundation modules**, responsible for user-facing features.
- [ ] Clean architecture (at module level): separation of UI, domain logics and platform logics.

![Architecture](https://github.com/superarcswift/SwiftCommunity/raw/master/Assets/Documentation/superarc.png)

### ViewModel

- Responsible for calling services classes to do business logics and prepare data model for presentations.

### ViewController

- Responsible for interaction with users, displaying results from its corresponding `ViewModel`.

### Component

- Responsible for managing dependencies required by its `ViewController` & `ViewModel`.
- Instantiate `ViewController`, `ViewModel`.
- Containing `ComponentRouter` used for navigating to outside components.
- Manage `Interface` to control interactions from outside.

### Coordinator (optional)

- Responsible for navigation.
- Instantiate `Component`.

## Example App
The example app demonstrates how you can use SuperArc to modularize an simple app by features and layers.

The sample app has the following specs:

- consists of **FeatureA**, **FeatureB**, **FeatureC** and **FeatureD**.
- **FeatureA** can navigate to **FeatureB**, **FeatureC** and **FeatureD**
- **FeatureB** can navigate to **FeatureA**, **FeatureC** and **FeatureD**


## Building and Running

After cloning the repository. Run the following command from the root folder of the cloned project to install all carthage dependencies in all subprojects:

```
swift run --package-path Tools/Bootstrap/ Bootstrap .
```

After this, you can open `SwiftCommunity.xcworkspace` and run the `SwiftCommunity` target to start the app.

## Authors

The app is developed by [An Tran](https://twitter.com/peacemoon).

The app icon is designed by [Khalid](https://github.com/ka95dev).

## Contributing

### Information
For convenience, all subprojects are kept in the same workspace & this reporistory so that we can iterate quickly without messing with versioning & package manager issues.

The goal for a stable version in the future is to have separated repositories for all components so that they can live independently from each others.

### Getting started

- Fork the repository.
- From the root workspace folder, run  `swift run --package-path Tools/Bootstrap/ Bootstrap .`  to install all dependencies.
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

MIT License. See [LICENSE](https://github.com/superarcswift/SwiftCommunity/blob/master/LICENSE)
