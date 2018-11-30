# DropdownButton

[![CI Status](https://img.shields.io/travis/alexanderkorus/DropdownButton.svg?style=flat)](https://travis-ci.org/alexanderkorus/DropdownButton)
[![Version](https://img.shields.io/cocoapods/v/DropdownButton.svg?style=flat)](https://cocoapods.org/pods/DropdownButton)
[![License](https://img.shields.io/cocoapods/l/DropdownButton.svg?style=flat)](https://cocoapods.org/pods/DropdownButton)
[![Platform](https://img.shields.io/cocoapods/p/DropdownButton.svg?style=flat)](https://cocoapods.org/pods/DropdownButton)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

![Preview](https://raw.githubusercontent.com/alexanderkorus/DropdownButton/master/dropdownbutton.gif)

## Requirements

## Installation

DropdownButton is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DropdownButton'
```

## Basic usage 

```swift
// Defining dropdown button like a UIbutton and configure it
let dropDownButton: DropdownButton = {
    let button: DropdownButton = DropdownButton()
    button.layer.cornerRadius = 10
    button.backgroundColor = .green
    button.setTitleColor(.white, for: .normal)
    button.selectedRowColor = .lightGray
    button.selectedRowTextColor = .white
    button.rowHeight = 40
    return button
}()

// The the Closure returns Selected Index and String 
dropDownButton.didSelect { (selectedText , index ,id) in
        self.valueLabel.text = "Selected String: \(selectedText) \n index: \(index)"
}

// seting options 
let options = ["Option 1", "Option 2", "Option 3"]
let ids = [0, 1, 2]

dropDownButton.setOptions(options: options, optionIds: ids, selectedIndex: 0)

```
### Other Options
Actions 

```swift
dropDownButton.expandList()  // To show the Drop Down Menu
dropDownButton.collapseList() // To hide the Drop Down Menu

````

Closures

```swift
listWillAppear() {
//You can Do anything when Dropdown menu willAppear 
}

listDidAppear() {
//You can Do anything when Dropdown menu listDidAppear
}

listWillDisappear() {
//You can Do anything when Dropdown menu listWillDisappear 
}

listDidDisappear() {
//You can Do anything when Dropdown menu listDidDisappear
}
```

## Customize DropdownButton 

You can customize these properties of the drop down:
- `hideOptionsWhenSelect` : This  option to hide the list when click option one item. Default value is `true`
- `selectedRowColor` : Color of selected Row item in DropDown Default value is `.cyan`
- `rowBackgroundColor` : Color of  DropDown Default value is `.white`
- `listHeight`: The maximum Height of of List. Default value is `150 ` 
- `rowHeight`: The  Height of of List in the List. Default value is  ` 30`
- `selectedIndex`: For preSelection of any of item in list

## Note :

1.If you are using Multiple Drop Downs in a Single ViewController, Must Kept reverse order on StoryBoard or addSubview()  to avoid Overlaying


## Author

Alexander Korus, alexander.korus@svote.io, based on iOSDropDown Library by jriosdev.


## License

DropdownButton is available under the MIT license. See the LICENSE file for more info.
