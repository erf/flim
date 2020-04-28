# flim

minimal data-driven 2d sprite game lib for Flutter

## Features

- fast buffered sprite rendering using Canvas.drawAtlas
- data-driven; store sprites and animations as json
- animated sprites ( with same sprite base type )
- abstractions for game, render-loop, game widget
- widgets for sprite and animated sprite
- loosely coupled pick-and-choose flutter package

## Usage

Inherit from `Game` and override methods to update, render and respond to user 
input and lifecycle events.

Use a `GameWidget`, `SpriteWidget` and `AnimatedSpriteWidget` to add content to 
your Flutter app.

Add `Sprite` and `SpriteAnimation`'s from code or json.

Pre-load and cache images by calling either: `Sprite.load`, 
`Assets.preLoadSprite` or `Assets.preLoadImages`. You usually do this in 
`Game.initialize`.

Render sprites by adding them to a `SpriteRenderer` or `SpriteBatch` and call 
it's `render` method in `Game.render`. Update animations in `Game.update`.

A render loop takes care of updating your game objects at 60 fps.

## Notes

- use `flutter format -l 100 .` to format code
