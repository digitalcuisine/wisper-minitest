# Wisper::MiniTest

MiniTest assertions/expectations and stubbing for [Wisper](https://github.com/krisleech/wisper).
Based on @krisleech work and his own [wisper-rspec](https://github.com/krisleech/wisper-rspec) gem.

[![Gem Version](https://img.shields.io/gem/v/wisper-minitest.svg)](https://rubygems.org/gems/wisper-minitest)
[![Build Status](https://img.shields.io/travis/digitalcuisine/wisper-minitest.svg)](https://travis-ci.org/digitalcuisine/wisper-minitest)

## Installation

```ruby
gem 'wisper-minitest', require: false
```

## Usage

### Broadcast assertion

In `test_helper`

```ruby
require 'wisper/minitest/assertions'
```

In your tests:
```ruby
assert_broadcast(:an_event) { publisher.execute }
```
This will match both `broadcast(:an_event)` and `broadcast(:an_event, :arg_1)`.


```ruby
# with optional arguments
assert_broadcast(:another_event, :arg1, :arg2) { publisher.execute }
```

With event arguments, it matches only if the event is broadcast with those 
arguments. This assertion matches `broadcast(:another_event, :arg1, :arg2)` but 
not `broadcast(:another_event)`.



## Todo

The [wisper-rspec](https://github.com/krisleech/wisper-rspec) gem is not fully
ported yet. Here's what's missing: 

- [x] Convert `broadcast` expectation to `assert_broadcast` assertion
- [ ] Add a `refute_broadcast` assertion
- [ ] Make those available as Minitest expectations too
- [ ] Document or implement a way to assert that a listener is receiving events 
- [ ] Port publisher stub feature 

## Contributing

Any contribution is welcome! Open an issue or send a pull request to get started.
