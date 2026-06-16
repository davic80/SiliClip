# SiliClip

A native Apple Silicon clipboard manager for macOS — a fork of [Clipy](https://github.com/Clipy/Clipy), rewritten to run natively on ARM64.

> **This is a fork of [Clipy](https://github.com/Clipy/Clipy) by the Clipy Project (MIT license).**
> Clipy runs via Rosetta 2 on Apple Silicon. SiliClip removes that dependency by targeting ARM64 natively and replacing archived third-party libraries with native macOS APIs.

---

## What's different from Clipy

| | Clipy | SiliClip |
|---|---|---|
| Architecture | Intel (x86_64) via Rosetta 2 | ARM64 native |
| Swift | 5.0 | 6.0 |
| Screenshot detection | [Screeen](https://github.com/Clipy/Screeen) (archived) | Native `NSMetadataQuery` |
| Analytics | Firebase (optional) | Removed |

Everything else — features, UX, keyboard shortcuts, snippet editor — works exactly the same as Clipy.

## Features

- Clipboard history saved to disk
- Snippet manager for frequently used text
- Menu bar access with keyboard shortcuts
- Screenshot capture to clipboard history (native, no third-party dependency)
- Auto-launch at login

## Requirements

- macOS 13 Ventura or later
- Apple Silicon Mac (M1 or later)

## Building

Open `Clipy.xcodeproj` in Xcode 16 or later. All dependencies are managed via Swift Package Manager — no extra steps needed.

For local development, switch to ad-hoc signing:

1. Open `Configurations/CodeSigning.xcconfig`
2. Uncomment `#include "Configurations/CodeSigning-AdHoc.xcconfig"`
3. Build the `Clipy` scheme

## License

MIT — see [LICENSE](LICENSE).

Original work copyright © 2015–2018 Clipy Project.
Modifications copyright © 2026 davic80.

## Credits

- [Clipy](https://github.com/Clipy/Clipy) — original project this is based on
- [Magnet](https://github.com/Clipy/Magnet) — keyboard shortcut handling
- [RxSwift](https://github.com/ReactiveX/RxSwift) — reactive bindings
- [Sparkle](https://github.com/sparkle-project/Sparkle) — auto-updates
- [swift-dependencies](https://github.com/pointfreeco/swift-dependencies) — dependency injection
- [sqlite-data](https://github.com/pointfreeco/sqlite-data) — persistence
- [@naotaka](https://github.com/naotaka) — original [ClipMenu](https://github.com/naotaka/ClipMenu), which Clipy is based on
