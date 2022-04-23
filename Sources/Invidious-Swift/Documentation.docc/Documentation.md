# ``Invidious_Swift``

An API wrapper for Invidious instances

## Overview

> This is taken from the [GitHub repo](https://github.com/WatchTubeTeam/Invidious-Swift)

This package uses the new async/await and concurrency stuff, so you will need iOS 15, macOS 12 or watchOS 8 or something like that

## Usage
Take a look at the [Invidious API Docs](https://docs.invidious.io/api/) and become familiar with it.

All you have to do is write the endpoint you need!

Let's say I need the current instance's stats, I would use the stats endpoint.
```swift
import Invidious_Swift

// Use inside of an async function
let data = await inv.stats()
// This exposes all of the stats from the current instance
let version = data?.software.version
```
You can access all the stuff as seen in the schema for the stats endpoint
```json
{
  "version": "String",
  "software": {
    "name": "invidious",
    "version": "String",
    "branch": "String"
  },
  "openRegistrations": "Bool",
  "usage": {
    "users": {
      "total": "Int32",
      "activeHalfyear": "Int32",
      "activeMonth": "Int32"
    }
  },
  "metadata": {
    "updatedAt": "Int64",
    "lastChannelRefreshedAt": "Int64"
  }
}
```
You can simply follow the same structure!

This applies to all endpoints available. Though, because of some issues, mixes from YouTube are not properly supported.

Here's a swiftUI example

```swift
import Invidious_Swift
import SwiftUI

struct ContentView: View {
    @State var txt: String! = nil // set it to nil as a start value, this will be used to check if its done loading the sub count
    var body: some View {
        if txt == nil { // if nil, nothing is loaded
            ProgressView()
                .progressViewStyle(.circular)
                .task { // start loading electroboom's channel
                    let electroboom = await inv.channel(udid: "UCJ0-OtVpF0wOKEqT2Z1HEtA") // this is electroboom's udid
                    txt = String(electroboom?.subCount ?? 0) // if any issue occurs, the electroboom variable will be nil. all endpoints will return nil if issues occur.
                }
        } else { // is not nil, show it
            Text("Electroboom has \(txt) subs!")
        }
    }
}
```

> Not everything available from Invidious is implemented, please tell us if you need anything through opening an issue or add it yourself by opening a PR!
## Topics

### Getting Started

- ``inv``
