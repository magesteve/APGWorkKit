# APGWorkKit

**APGWorkKit** is a Swift package providing iWork-style UI components for macOS and SwiftUI apps.  
It bundles ready-to-use windows, panels, and utilities such as About boxes, Welcome screens, What's New dialogs, FAQ viewers, Settings panels, and promotional showcases.  
Designed to give applications a polished, professional "Apple Work-style" look and feel.

📦 Repository: https://github.com/magesteve/APGWorkKit  
🔖 Current version: **0.6.0**

---

## Highlights

- **APGWorkAbout** — An iWork-style About window with app icon, version, copyright, and links to acknowledgments and licenses.  
- **APGWorkWhatsNew** — A What's New window showing feature highlights with optional external links.  
- **APGWorkWelcome** — A Welcome screen with subtitle, agreement link, and stacked images.  
- **APGWorkGetStarted** — A Get Started panel with feature list and buttons for creating or opening documents.  
- **APGWorkFAQ** — An FAQ viewer supporting collapsible question/answer sections and reference links.  
- **APGWorkPromos** — A promotional window cycling through tiles with text, images, and links.  
- **APGWorkSettings** — A multi-panel settings window with icon-based navigation and customizable control panels.  
- **APGWorkSoundCP / APGWorkDebugCP** — Example control panels for sound and debug settings.  

> Most components are currently **macOS-only** using AppKit + SwiftUI, but remain cross-platform aware with `#if canImport(AppKit)`.

---

## Installation (Swift Package Manager)

### In Xcode
1. Go to **File → Add Packages…**
2. Enter the URL:  
   ```
   https://github.com/magesteve/APGWorkKit
   ```
3. Select **Up to Next Major**.
4. Add `APGWorkKit` to your targets.

### In Package.swift
```swift
dependencies: [
    .package(url: "https://github.com/magesteve/APGWorkKit", from: "0.6.0")
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "APGWorkKit", package: "APGWorkKit")
        ]
    )
]
```

---

## Usage

APGWorkKit is based on an

### About Window
```swift
APGWorkAbout.show()
```

### What's New Window
```swift
if APGWorkWhatsNew.canShow {
    APGWorkWhatsNew.show()
}
```

### Welcome Window
```swift
APGWorkWelcome.show()
```

### Get Started Window
```swift
APGWorkGetStarted.show()
```

### FAQ Window
```swift
APGWorkFAQ.show()
```

### Promos Window
```swift
APGWorkPromos.show()
```

### Settings Window
```swift
APGWorkSettings.show()
```

### Custom Control Panel
Subclass `APGWorkControlPanel` to add your own panels:

```swift
public class MyControlPanel: APGWorkControlPanel {
    public static func register() {
        let cp = MyControlPanel(token: "com.example.mycp")
        cp.registerControlPanel(name: "My Panel", shortName: "Panel", symbolName: "gear")
    }

    override public func makeControlPanelView() -> some View {
        VStack {
            Text("My Custom Panel")
        }
    }
}
```

---

## Sample Code
See [APGExample](https://github.com/magesteve/APGExample) for sample usage.

---

## License
MIT License — see [LICENSE](LICENSE)  
Created by **Steve Sheets**, 2025
