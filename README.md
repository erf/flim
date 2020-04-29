# flim

minimal data-driven sprite game lib for Flutter

## Features

- sprite and animated sprites with transforms 
- buffered sprite rendering using Canvas.drawAtlas (fast!)
- data-driven; load sprites and animations as json
- abstractions for game, render-loop, game widget and more
- minimal and loosely coupled Flutter package

## Usage

Inherit from `Game` and override methods to update, render and respond 
to user input and lifecycle events.

Wrap your game in a `GameWidget` or add a single sprite or sprite animation 
using `SpriteWidget` or `AnimatedSpriteWidget`.

Add `Sprite` and `AnimatedSprite` in code or from json assets by calling
`Sprite.loadJson` or `Assets.loadJson` during `Game.initialize`.

Load (and cache) images by calling `Sprite.load` or `Assets.loadImage` 
during `Game.initialize`.

Render sprites using `SpriteBatchMapRenderer` (in most cases), and call it's 
`render` method in `Game.render`.

Call `AnimatedSprite.update` in `Game.update`, before adding its `sprite` to a 
renderer.

Remember to call `clear` on any renderer before adding sprites to it in the 
update method.

A render loop takes care of updating your game objects at ~60 fps.

See [example](example) folder for examples.

## Notes

Format code using `flutter format -l 100 .`

Inspired by [Flame](https://github.com/flame-engine/flame)
