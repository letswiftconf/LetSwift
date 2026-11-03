# Contributing to Let'Swift

Thanks for helping with the Let'Swift app. Volunteers maintain it, so small, focused changes are the easiest to review.

## Requirements

- Xcode 26 or later
- Deployment targets: iOS 26, watchOS 26, macOS 26, visionOS 26
- Swift 6 language mode for every target

## Branches

- The active development branch is the newest `YYYY/develop*` branch (currently `2026/develop_10`).
- Create your branch from it and open the pull request against it.
- Name your branch after what it does, e.g. `fix/video-search` or `feature/search-tab`.

## Project layout

| Folder | What's in it |
| --- | --- |
| `LetSwift/` | iOS app (Home web view, Videos, More) |
| `LetSwift-watchOS/` | Watch timetable app |
| `Shared/` | Code and resources used by more than one target |
| `LetSwift/Resources/Previous/videos.json` | Past talk videos, newest year first |

## Adding a year of videos

Add one block at the top of `LetSwift/Resources/Previous/videos.json`, one video per line:

```json
{
  "year": 2025,
  "videos": [
    {"id": "<YouTube video ID>", "title": "...", "speaker": "...", "duration": "25:10", "slides": "https://..."}
  ]
}
```

`speaker`, `duration` and `slides` are optional. Thumbnails and YouTube links are built from `id`.

## Before you open a pull request

- Build every scheme you touched with no new warnings.
- Run the app and check your change on a simulator or device.
- Keep user-facing text in `Localizable.xcstrings` with Korean and English.
- Describe what changed and why, and add screenshots for UI changes.

## Conference details

Conference year, dates and location live in `Constants.Conference`. Update them there each year.

## License

By contributing, you agree that your contributions are licensed under the [MIT License](LICENSE).
