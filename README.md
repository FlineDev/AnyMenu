
<p align="center">
    <img src="https://raw.githubusercontent.com/Flinesoft/AnyMenu/stable/Logo.png"
      width=600 height=167>
</p>

<p align="center">
    <a href="https://www.bitrise.io/app/5c5c85144ac220cf">
        <img src="https://www.bitrise.io/app/5c5c85144ac220cf/status.svg?token=Z7zf4Dka_bWVtxCAd6jAmA&branch=stable"
             alt="Build Status">
    </a>
    <a href="https://codebeat.co/projects/github-com-flinesoft-anymenu-stable">
        <img alt="codebeat badge" src="https://codebeat.co/badges/024e96f9-2293-407b-8f6c-52b494a26336" />
    </a>
    <a href="https://github.com/Flinesoft/AnyMenu/releases">
        <img src="https://img.shields.io/badge/Version-1.0.0-blue.svg"
             alt="Version: 1.0.0">
    </a>
    <img src="https://img.shields.io/badge/Swift-4.0-FFAC45.svg"
         alt="Swift: 4.0">
    <img src="https://img.shields.io/badge/Platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-FF69B4.svg"
        alt="Platforms: iOS | macOS | tvOS | watchOS">
    <a href="https://github.com/Flinesoft/AnyMenu/blob/stable/LICENSE.md">
        <img src="https://img.shields.io/badge/License-MIT-lightgrey.svg"
              alt="License: MIT">
    </a>
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="https://github.com/Flinesoft/AnyMenu/issues">Issues</a>
  • <a href="#contributing">Contributing</a>
  • <a href="#license">License</a>
</p>


# AnyMenu

A menu framework for any use case.

## Installation

### Carthage

Place the following line to your Cartfile:

``` Swift
github "Flinesoft/AnyMenu" ~> 1.0
```

Now run `carthage update`. Then drag & drop the AnyMenu.framework in the Carthage/Build folder to your project. Now you can `import AnyMenu` in each class you want to use its features. Refer to the [Carthage README](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application) for detailed / updated instructions.

### CocoaPods

Add the line `pod 'AnyMenu'` to your target in your `Podfile` and make sure to include `use_frameworks!`
at the top. The result might look similar to this:

``` Ruby
platform :ios, '8.0'
use_frameworks!

target 'MyAppTarget' do
    pod 'AnyMenu', '~> 1.0'
end
```

Now close your project and run `pod install` from the command line. Then open the `.xcworkspace` from within your project folder.
Build your project once (with `Cmd+B`) to update the frameworks known to Xcode. Now you can `import AnyMenu` in each class you want to use its features.
Refer to [CocoaPods.org](https://cocoapods.org) for detailed / updates instructions.

## Usage

Please have a look at the **Demo project** for a complete example on how to use this framework.

---
#### Features Overview

- [Short Section](#short-section)
- Sections Group
  - [SubSection1](#subsection1)
  - [SubSection2](#subsection2)

---

### Short Section

TODO: Add some usage information here.

### Sections Group

TODO: Summarize the section here.

#### SubSection1

TODO: Add some usage information here.

#### SubSection2

TODO: Add some usage information here.


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
