# Contributing to SiliClip

Thank you for contributing to SiliClip!

SiliClip is a fork of [Clipy](https://github.com/Clipy/Clipy) targeting native Apple Silicon (ARM64). Contributions that improve ARM64 compatibility, fix bugs, or modernize the codebase are especially welcome.

## Building

1. Clone the repo
2. Open `Clipy.xcodeproj` in Xcode 16 or later
3. Switch to ad-hoc signing: open `Configurations/CodeSigning.xcconfig` and uncomment the AdHoc include
4. Select the `SiliClip` scheme and build

## Localization

Localization files are in `Clipy/Resources/Localizable.xcstrings`. Edit that file to add or modify translations.

## Pull Requests

- Keep changes focused — one concern per PR
- If fixing a bug that also exists in upstream Clipy, note it in the PR description
- CI must pass before merging
