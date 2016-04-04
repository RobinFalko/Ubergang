# Ubergang (Übergang)

Ubergang is a low level tweening engine.

## Features

- [x] Tween numeric values and CGAffineTransforms
- [x] Cubic, Elastic and Linear easings
- [x] Generic tween setup
- [x] Repeat and Yoyo tween options
- [x] Memory management for strong and weak tween object references


## Usage

### Start a simple numeric Tween (Double)

```swift
UTweenBuilder
  .to( 10.0, current: { 0.0 }, update: { value in print("test double: \(value)") }, duration: 5, id: "doubleTween")
  .start()
```
> This Tween with id 'doubleTween' goes from 0.0 to 10.0 over 5 seconds using a linear easing by default. The current value will be printed with every update.



### Start a weak numeric Tween (Int)

```swift
var tween: NumericTween<Int>?

func run() {
  tween = UTweenBuilder
      .to( 10, current: { 0 }, update: { value in print("test int: \(value)") }, duration: 5, id: "intTween")
      .ease(Elastic.easeOut)
      .memoryReference(.Weak)
      .start()
}
```
> This Tween with id 'intTween' goes from 0 to 10 over 5 seconds using an elastic easing. The current value will be printed with every update.
.memoryReference(.Weak) will store this tween weakly, Ubergang won't increment the reference count. It's up to you to keep the Tween alive.



## Todos

- [x] Tween sequences
- [x] Logging and log levels
- [x] Timeline controls
