# flim

minimal data-driven 2d sprite game lib for Flutter

## Features

- fast buffered sprite rendering using Canvas.drawAtlas
- animated sprites
- data-driven; load sprites and animations as json
- abstractions for game, render-loop, game widget
- widgets for sprites and animated sprites
- minimal loosely coupled flutter package

## Usage

Create a subclass of `Game` and override methods to update, render and respond 
to user input and lifecycle events.

Wrap your game in a `GameWidget` or add a single sprite or sprite animation 
using `SpriteWidget` and `AnimatedSpriteWidget`.

Add `Sprite` and `AnimatedSprite` from either code or json assets.

Pre-load and cache images by calling either: `Sprite.load`, 
`Assets.preLoadSprite` or `Assets.preLoadImages` in `Game.initialize`.

Render sprites by adding them to a `SpriteRenderer`, `SpriteBatchRenderer` or
`SpriteBatchMapRenderer`. Call it's `render` method in `Game.render`.

Update `AnimatedSprite` in `Game.update` before adding to a renderer (remember 
to clear renderers before adding sprites).

A render loop takes care of updating your game objects at ~60 fps.

## Notes

- format code using `flutter format -l 100 .`
