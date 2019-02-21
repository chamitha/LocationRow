# LocationRow

## Introduction

LocationRow is a Eureka custom row that allows you to search and select an address or location of interest using the map-based MKLocalSearch.

## Installation

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
iOS 12.0+
Xcode 10.1+
Swift 4.2+
Eureka 4+

## Author
Chamitha Wijesekera
