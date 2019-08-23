## SwiftVideos

[![License](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/Swift-5.0-blue.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/Xcode-10-blue.svg)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/platforms-iOSv|%20tvOS%20|%20macOS%20|%20watchOS%20-blue.svg)](https://opensource.org/licenses/MIT)

Collection of Swift/iOS-related development videos. 

This project serves as a showcase for the SuperArc project. 

The SuperArc project aims to standardize many common building blocks which can help developers to kickstart new iOS projects quickly.

The goal is to have a set of modules to create a component-based MVVM-C (Model-View-ViewModel-Coordinator) architecture for iOS apps. The modules are intended to use together but each module should be able to be integrated into any other iOS projects. For more information about the SuperArc project, please take a look at [](its repo)   

## Content

All content are curated from external sources such as Vimeo, Youtube or WWDC live streams. This is insipred heavily from [SwiftTube](http://www.swifttube.co/) and [talk & coffe app]()

## App Features
- Use json as database
- View list of iOS/Swift related conferences
- View list of videos of conferences
- View list of speakers of conferences
- Use git for manage the json database (https://github.com/libgit2/objective-git)

## Technologies

**Tech-Stack**

**Architecture**

- µfeatures modules
- Clean architecture (at module level)

**Tests**

**Package manager**


## Tools

* Swiftlint: https://github.com/realm/SwiftLint

* Danger: https://danger.systems/

* Documentation: https://github.com/realm/jazzy

## Architecture

![Architecture](Assets/Documentation/superarc.png)

### ViewModel
- Responsible for performing business logic

### ViewController
- Responseible for interaction with users, displaying result from `ViewModel`

### Component
- Responseible for managing dependencies required by its `ViewController` & `ViewModel`
- Instantiate `ViewController`, `ViewModel`

### Coordinator (optional)
- Responsible for navigation
- Instantiate `Component`

## Building and Running

## Contribute

## License
MIT License. See [LICENSE](LICENSE)
