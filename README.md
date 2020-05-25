# flim ✨

Minimal data-driven sprite render lib for Flutter

## Features

- Sprites and sprite animations with transforms 
- Buffered sprite rendering using Canvas.drawAtlas (fast!)
- Data-driven: load sprites and animations as json
- Abstractions for game, render-loop, widgets and more
- Generic asset cache used for images, json and more
- Minimal and loosely coupled Flutter package

## Usage

Add `flim` to your `pubspec.yaml`:

```yaml
dependencies:
  flim:
```

See [USAGE.md](USAGE.md) and [example](example) to learn.

Use `dartdoc` or `scripts/docs.sh` to generate docs.

## Notes

I'd like to keep **flim** minimal, so i won't be adding lots of game features.

Code is expected to break.

Code and doc improvements are welcome.

Inspired by [Flame](https://github.com/flame-engine/flame)

