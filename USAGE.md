# Usage

Here is a short summary of the library.

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

`AssetCache`, or one of its sub-classes, is used for loading and caching images, 
json files and more.

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

