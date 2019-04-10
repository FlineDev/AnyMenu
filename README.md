
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
    <img src="https://img.shields.io/badge/Swift-3.1-FFAC45.svg"
         alt="Swift: 3.1">
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

An easy to use menu framework for any styling use case.

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

### Accio

Add the following to your Package.swift:

```swift
.package(url: "git@github.com:Flinesoft/AnyMenu.git", .branch("stable")),
```

Next, add `AnyMenu` to your App targets dependencies like so:

```swift
.target(
    name: "App",
    dependencies: [
        "AnyMenu",
    ]
),
```

Then run `accio update`.

## Usage

Please have a look at the **Demo project** for a complete example on how to use this framework.

---
#### Features Overview

- [Basic Configuration](#basic-configuration)
- Customization Points
  - [Menu above or below content](#menu-above-or-below-content)
  - [Menu Animation](#menu-animation)
  - [Content Animation](#content-animation)
  - [Menu button](#menu-button)

---

### Basic Configuration

#### Initialize `AnyMenuViewController` and call `present(in:)`

Using AnyMenu is pretty straightforward. First, open your `AppDelegate` file and create an `AnyMenuViewController` instance in your `application(_:didFinishLaunchingWithOptions:)`. You'll see that you need to provide a `UIViewController` for the menu and a `UIViewController` as your initial content along the process. After initializing it call the `present` method with your window property. Everything put together, your `AppDelegate` might look something like this:

```swift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Stored Instance Properties
    var window: UIWindow?

    // MARK: - App Lifecycle Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // setup your menu view controller & initial content view controller
        let menuViewController = MenuViewController()
        let initialContentViewController = ContentViewController(backgroundColor: .darkGray)

        let anyMenuViewController = AnyMenuViewController(
            menuViewController: menuViewController,
            contentViewController: UINavigationController(rootViewController: initialContentViewController),
            menuOverlaysContent: false
        )
        anyMenuViewController.present(in: &window)

        return true
    }
}
```
The important lines to point out here are:

```swift
let anyMenuViewController = AnyMenuViewController(menuViewController: ..., contentViewController: ..., menuOverlaysContent: ...)
```
This creates the container view controller to what you need to assign both your menu and the current content to. The next important line is:

```swift
anyMenuViewController.present(in: &window)
```
This calls the `present` method which ensures that the container view controller is set as the root view of the window. You don't have to deal with the window at all – in fact if the `window` property is `nil` the `present` method will initialize a `UIWindow` object for you. Just make sure not to forget placing `&` in front of the window parameter.

Now the menu should already exist and be showing your initial content view. You can actually test this out by running your app and swiping from the left edge of the screen to open the menu.

But we have two more imprtant things to do from here:

1. Your users need to be able to **open the menu** with a _button_ (the swipe from the edge of the screen should already work)
2. When your users **select an entry in your menu**, you need to _set the content view_

We tried to make both of these steps as simple as possible:

#### How to show the menu

For opening the menu you basically have two options:

- Either you call `anyMenuViewController?.openMenu()` in your content view controllers programmatically
  - this way you would need to add a button somewhere in your view or in the navigation bar and define a target function yourself
- Or – and even simpler – you can use one of our **button factory methods** which are already setup to open the menu for you
  - call `makeMenuBarButtonItem(menuIconType: .default)` to get a `UIBarButtonItem` for navigation bars
  - call `makeButton(menuIconType: .default)` to get a `UIButton` to place it in some other view

As an example here's what your content view controllers `viewDidLoad()` might look like:

```swift
override func viewDidLoad() {
    super.viewDidLoad()

    if navigationController != nil {
        // add hamburger button to navigation bar
        navigationItem.leftBarButtonItem = makeMenuBarButtonItem(menuIconType: .default)
    } else {
        // add hamburger button to view
        let menuButton = makeButton(menuIconType: .default)
        // menuButton.frame = CGRect(...)
        view.addSubview(menuButton)
    }
}
```

#### How to change the content

For **selecting an entry in your menu** and setting the content view you just need to assign your chosen content controller to `anyMenuViewController?.contentViewController` in your menu view controller. Additionally you probably also want to **close the menu** via `anyMenuViewController?.closeMenu()` afterwards. For example, given you are using a `UITableView` in your menu, the `tableView(_:didSelectRowAt indexPath)` might look something like this:

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    switch indexPath.row {
    case 0:
        anyMenuViewController?.contentViewController = ContentViewController(backgroundColor: .yellow)
        anyMenuViewController?.closeMenu()

    case 1:
        anyMenuViewController?.contentViewController = UINavigationController(rootViewController: ContentViewController(backgroundColor: .blue))
        anyMenuViewController?.closeMenu()

    default:
        fatalError()
    }
}
```

That's it! 🎉 You should now have your menu **setup and working**. Run your app and test it out! If you come across any hurdles, feel free to open an issue here on GitHub.

### Customization Points

We tried to make sure AnyMenu is as customizable as possible while keeping the usage simple. Here's what you can currently customize:

#### Menu above or below content

By default the menu view is put below the content when the menu is opened. So the content is "swiped away". If you want the menu to be "swiped in" above the content instead, then you can reach this by provising `true` for the `menuOverlaysContent` parameter when initializing the `AnyMenuViewController`.

#### Menu Animation

TODO

#### Content Animation

TODO

#### Menu button

The `makeMenuBarButtonItem(menuIconType:)` and `makeButton(menuIconType:)` factory methods both create buttons and automatically generate a hamburger button. You can actually customize the button image by providing a different `MenuIconType`. The following cases are available:

- `default`: A predefined hamburger icon with three lines and following the Apple Human Interface Guidelines.
- `roundedLines`: The same as `default` except for that the line ends are rounded.
- `customConfig(MenuIconConfig)`: Provide a custom `MenuIconConfig` where you can exactly specify look of the hamburger icon. See [MenuIconConfig](https://github.com/Flinesoft/AnyMenu/blob/stable/Sources/Code/MenuIconConfig.swift).
- `customImage(UIImage)`: Provide a custom image icon for the menu button.


## Contributing

Contributions are welcome. Please just open an Issue on GitHub to discuss a point or request a feature or send a Pull Request with your suggestion. Please also try to follow the same syntax and semantic in your **commit messages** (see rationale [here](http://chris.beams.io/posts/git-commit/)).


## License
This library is released under the [MIT License](http://opensource.org/licenses/MIT). See LICENSE for details.
