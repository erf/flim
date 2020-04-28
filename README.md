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

Add `Sprite`'s and `AnimatedSprite`'s from either code or json.

Pre-load and cache images by calling either: `Sprite.load`, 
`Assets.preLoadSprite` or `Assets.preLoadImages` in `Game.initialize`.

Render sprites by adding them to a `SpriteRenderer`, `SpriteBatch` or 
`SpriteBatchMap`. Call it's `render` method in `Game.render`. 

Update `AnimatedSprite`'s in `Game.update` before adding them to a renderer. 

A render loop takes care of updating your game objects at ~60 fps.

## Notes

- use `flutter format -l 100 .` to format code
