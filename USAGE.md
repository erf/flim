# Usage

Here is a short summary of the library.

#### Game and widgets

Inherit from `Game` and override methods to `update` and `render`, `Sprite`s 
and `AnimatedSprite`s, and respond to events. Add your `Game` to a `GameWidget`. 

Use an `AnimatedSpriteGame` for a single `AnimatedSprite`, or `SpriteWidget` 
for a single `Sprite`.

A `RenderLoop` in `GameRenderBox` updates your game at ~60 fps and gives you 
delta time since previous update.

#### Initialize assets

Load and cache `Sprite` and `AnimatedSprite` types from json assets using 
`Sprite.loadJson` and `AnimatedSprite.loadJson`.

Load and cache images by calling `Sprite.loadImage`,`AnimatedSprite.loadImages`.
`loadJson` will call `loadImages` with the stored asset path.

`asset_cache` is used for loading and caching images, json files and more. You 
need to pass your own `ImageAssetCache` or `JsonAssetCache` when loading assets.

#### Render 

Render sprites using a `SpriteBatchMap` (for most cases). Add sprites to it by
calling `add`, then call `SpriteBatchMap.render` in `Game.render`.

Update animations using `AnimatedSprite.update` in `Game.update`. Then call
`SpriteBatchMap.clear` before adding `AnimatedSprite.sprite` to a 
`SpriteBatchMap`.

