# ios-counter-app

A minimal SwiftUI iPhone app that validates the Mac `xcodebuild` path end-to-end.

## What it is

A single-screen counter. The screen shows a number with **+**, **−**, and **Reset**
buttons. All counter state lives in `CounterViewModel` (an `ObservableObject`) — the
SwiftUI view holds none of it.

### CounterViewModel rules
- `increment()` — adds one
- `decrement()` — subtracts one, **clamped so the count never goes below 0**
- `reset()` — sets the count back to 0

## Project layout

```
CounterApp/
  CounterApp.xcodeproj         # minimal, iPhone-only app target + unit-test target
  CounterApp/
    CounterAppApp.swift        # @main app entry
    ContentView.swift          # the one screen, observes CounterViewModel
    CounterViewModel.swift     # owns the count
  CounterAppTests/
    CounterViewModelTests.swift # XCTest unit tests (no UI tests)
```

## Tests

XCTest unit tests on `CounterViewModel` cover increment, decrement, reset, and the
no-negative-below-zero rule. There are no UI tests.

## Running the tests on a Mac

The shared `CounterApp` scheme is auto-discovered. Pick any available iOS Simulator
(no device name is hardcoded), e.g. select a UDID dynamically:

```sh
cd CounterApp
UDID=$(xcrun simctl list devices available --json | python3 -c "
import json,sys
d=json.load(sys.stdin)['devices']
for r in sorted(d, reverse=True):
    for dev in d[r]:
        if dev.get('isAvailable') and 'iPhone' in dev['name']:
            print(dev['udid']); sys.exit(0)")
xcodebuild test -project CounterApp.xcodeproj -scheme CounterApp -destination "id=$UDID"
```
