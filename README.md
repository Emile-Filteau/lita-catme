# lita-catme

[![Build Status](https://travis-ci.org/Emile-Filteau/lita-catme.png?branch=master)](https://travis-ci.org/Emile-Filteau/lita-catme)
[![Coverage Status](https://coveralls.io/repos/github/Emile-Filteau/lita-catme/badge.svg?branch=master)](https://coveralls.io/github/Emile-Filteau/lita-catme?branch=master)

Lita handler that provides several commands to fetch random cat images from the cat api.

## Installation

Add lita-catme to your Lita instance's Gemfile:

``` ruby
gem "lita-catme"
```

## Example Usage

```
User>> lita cat me
Lita>> http://24.media.tumblr.com/tumblr_low6n5JHJF1qbhms5o1_500.jpg
User>> lita cat categories
Lita>>hats
space
funny
sunglasses
boxes
caturday
ties
dream
kittens
sinks
clothes
User>> lita cat in boxes
Lita>> http://25.media.tumblr.com/tumblr_lwwd01DBVo1r0mbi6o1_1280.jpg
```
