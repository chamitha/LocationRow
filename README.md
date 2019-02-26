# LocationRow

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) ![Cocoapods platforms](https://img.shields.io/cocoapods/p/LocationRow.svg) ![Cocoapods](https://img.shields.io/cocoapods/v/LocationRow.svg)

## Introduction

LocationRow is a [Eureka](https://eurekacommunity.github.io) custom row that allows you to search and select an address or location of interest using the map-based [MKLocalSearch](https://developer.apple.com/documentation/mapkit/mklocalsearch).

![](https://github.com/chamitha/LocationRow/blob/master/LocationRow.gif)

## Installation

### Carthage
```
github "chamitha/LocationRow" ~> 1.0
```

### CocoaPods
```
pod 'LocationRow', '~> 1.0'
```

## Usage

```
form
    +++ Section("LocationRow Example")
    <<< LocationRow("row1") { (row) in
        row.placeholder = "Location"
        }.onPresent({ (_, presentingViewController) in
            presentingViewController.title = "Location"
            presentingViewController.placeholder = "Enter Location"
        })
```

## Requirements
* iOS 12.0+
* Xcode 10.1+
* Swift 4.2+
* Eureka 4+

## Author

[Chamitha Wijesekera](https://github.com/chamitha)
