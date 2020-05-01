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

Here is a short summary of the library.

Also see [example](example).

#### Game and widgets

Inherit from `Game` and override methods to `initialize`, `update` and `render`, 
`Sprite`s and `AnimatedSprite`s, and respond to events. Add your `Game` to a `GameWidget`. 

Use an `AnimatedSpriteGame` for a single `AnimatedSprite`, or `SpriteWidget` for a 
single `Sprite`.

A `RenderLoop` in `GameRenderBox` updates your game at ~60 fps and gives you 
delta time since previous update.

#### Initialize assets

Initialize your sprite objects in `Game.initialize`, and return the `Game` as
a future. 

We have helper methods for loading images and json files using a generic `AssetCache`.

Load (and cache) `Sprite` and `AnimatedSprite` (or other objects) from json assets 
by calling `Sprite.loadJson`, `AnimatedSprite.loadJson` or `JsonAssets.instance.load`.
Or add them by code.

Load (and cache) images by calling `Sprite.loadImage`,`AnimatedSprite.loadImages` 
or `ImageAssets.instance.load`.

#### Render 

Render sprites using a `SpriteBatchMap` (in most cases). Add sprites to it by
calling `add`, then call `SpriteBatchMap.render` in `Game.render`.

Update animations using `AnimatedSprite.update` in `Game.update`. Then call
`SpriteBatchMap.clear` before adding `AnimatedSprite.sprite` to a `SpriteBatchMap`.

## Notes

I'd like to keep this minimal with focus on fast rendering of sprites, so i won't 
be adding a bunch of "game" features. 

And API will likely break (as i like to experiment and optimize).

But code and doc improvements are welcome (keep it polite and no demands).

Inspired by [Flame](https://github.com/flame-engine/flame)

