# CHANGELOG

## [1.1.0] - 6 dec 2023
- set sdk env > 2.18.0 <= 4.0.0
- update asset_cache -> 2.1.0
- add lints 3.0.1
- add vscode example launcher
- remove forced null check
- fix imports

## [1.0.0] - 12 March 2021
- null-safe version !
- code cleanup and a few API changes

## [0.4.0] - 12 March 2021
- use asset_cache package
- removed internal AssetCache
- pass AssetCache via `loadJson` or `loadImage`

## [0.3.1]
- format code
- minor json load improvement
- update README

## [0.3.0]
- refactor and simplify Sprite (and json format) by removing ImageRect
- rename Transform2 -> Transform2D
- more lambdas

## [0.2.4]
- update README 

## [0.2.0]
- rename sprite load to loadImage
- update docs

## [0.1.1]
- initial release!
- sprites and sprite animations
- buffered sprite rendering using Canvas.drawAtlas
- load sprites from json assets
- game, render box, render-loop, widgets+
- generic asset cache for images, json, strings etc
- examples using sprites, animations, keyboard+
