# flim ✨

minimal data-driven sprite render lib for Flutter

## Features

- sprite and animated sprites with transforms 
- buffered sprite rendering using Canvas.drawAtlas (fast!)
- data-driven; load sprites and animations as json
- abstractions for game, render-loop, widgets and more
- generic asset cache used for images, json and more
- minimal and loosely coupled Flutter package

## Usage

Add [flim](https://pub.dev/packages/flim) as a dependency in your `pubspec.yaml`.

For a short introduction see [USAGE](USAGE.md),

.. or check out the [example](example) folder.

but the main idea is; get a bunch of data and render it really fast, 

using a few pragmatic, loosely coupled abstractions.

## Notes

I'd like to keep **flim** minimal, so i won't be adding lots of "game" features.

Code is expected to break (as i like to experiment).

Code and doc improvements are welcome :-)

Inspired by [Flame](https://github.com/flame-engine/flame)

