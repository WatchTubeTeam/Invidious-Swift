# Invidious-Swift
## An API wrapper for Invidous

Very cool, will be used in WatchTube's SwiftUI rewrite (not done yet as of writing).

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
import swiftui

struct contentview: View {
  @State var txt = "loading..."
  var body: some View {
    Text("Electroboom has \(txt) subs")
      .task {
        let electroboom = await inv.channel(udid: "Electroboom") // invidious supports channel names if they contain no spaces else use channel udid for this
        txt = String(electroboom.subCount)
      }
  }
}
```

ok very cool also i wrote this swiftui example on my phone can someone make a pr to fix any bugs with this lol
