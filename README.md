# flim ✨

minimal data-driven sprite game lib for Flutter

## Features

- sprite and animated sprites with transforms 
- buffered sprite rendering using Canvas.drawAtlas (fast!)
- data-driven; load sprites and animations as json
- abstractions for game, render-loop, input, widgets and more
- minimal and loosely coupled Flutter package

## Usage

Inherit from `Game` and override methods to update, render and respond 
to user input and lifecycle events.

Wrap your game or animation in a `GameWidget`, or add a single sprite using 
`SpriteWidget`.

Add `Sprite` and `AnimatedSprite` in code or from json assets by calling
`Sprite.loadJson` or `Assets.loadJson` during `Game.initialize`.

Load (and cache) images by calling `Sprite.load`,`AnimatedSprite.load` or 
`Assets.instance.loadImage` during `Game.initialize`.

Render sprites using a `SpriteBatchMap` (in most cases), and call it's
`render` method in `Game.render`.

Call `AnimatedSprite.update` in `Game.update` before adding its `sprite` to a 
`SpriteBatchMap`. Remember to call `SpriteBatchMap.clear` before adding sprites 
to it.

A render loop takes care of updating your game objects at ~60 fps.

See [example](example) folder for examples.

## Notes

Format code using `flutter format -l 100 .`

Inspired by [Flame](https://github.com/flame-engine/flame)
