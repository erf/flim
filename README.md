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

Add `Sprite` and `AnimatedSprite` from code or from json assets by calling
`Sprite.loadJson`, `AnimatedSprite.loadJson` or `Assets.instance.loadJson` 
during `Game.initialize`.

Load (and cache) images by calling `Sprite.load`,`AnimatedSprite.load` or 
`Assets.instance.loadImage` during `Game.initialize`.

Render sprites using a `SpriteBatchMap` (in most cases). Add your sprite to it,
then call `SpriteBatchMap.render` in `Game.render`.

To update animations call `AnimatedSprite.update` in `Game.update`. Then call
`SpriteBatchMap.clear` before passing `AnimatedSprite.sprite` to 
`SpriteBatchMap.add`.

A render loop takes care of updating your game objects at ~60 fps.

See [example](example) folder for examples.

## Notes

Format code using `flutter format -l 100 .`

Inspired by [Flame](https://github.com/flame-engine/flame)
