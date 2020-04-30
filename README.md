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

Inherit from `Game` and override methods to `initialize`, `update` and `render`, 
`Sprite`s and `AnimatedSprite`s, and respond to events.

Add your `Game` to a `GameWidget`. Use an `AnimatedSpriteGame` for a single 
`AnimatedSprite`, or `SpriteWidget` for a single `Sprite`.

Add `Sprite` and `AnimatedSprite` from code or from json assets by calling
`Sprite.loadJson`, `AnimatedSprite.loadJson` or `JsonAssets.instance.load`
during `Game.initialize`.

Load (and cache) images by calling `Sprite.load`,`AnimatedSprite.load` or 
`ImageAssets.instance.load` during `Game.initialize`.

Render sprites using a `SpriteBatchMap` (in most cases). Add sprites to it by
calling `add`, then call its `render` method in `Game.render`.

To update animations call `AnimatedSprite.update` in `Game.update`. Then call
`SpriteBatchMap.clear` before passing `AnimatedSprite.sprite` to 
`SpriteBatchMap.add`.

A `RenderLoop` in `GameRenderBox` updates your game at ~60 fps, and gives you 
delta time (dt) since previous update.

See [example](example) folder for examples.

## Notes

Format code using `flutter format -l 100 .`

Inspired by [Flame](https://github.com/flame-engine/flame)
