# AutoLayoutSugar
Синтаксический сахар для верстки с использованием подходов Auto Layout

[![Language: Swift 4.0](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat")](https://developer.apple.com/swift) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

### Usage
##### Prepare for auto layout
All we know, that auto layout engine switches on only if we'll set view's translatesAutoresizingMaskIntoConstraints property to false.
Without autoLayoutSugar we write:
```
view.translatesAutoresizingMaskIntoConstraints = false
```
after:
```
view.prepareForAutoLayout()
```
Also, `prepareForAutoLayout` method returns `view`- we can chain something if needed after this method calling.
##### Custom constraint creation
before:
```
let viewBottomConstraint = view.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
let viewTopConstraint = view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10)
```
after:
```
let viewBottomConstraint = view.bottomAnchor ~= superview.bottomAnchor
let viewTopConstraint = view.topAnchor ~= superView.topAnchor + 10
```
##### Pin edges to superview's edges with insets
before:
```
NSLayoutConstraint.activate([
	view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 10),
	view.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 10),
	view.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -10),
	view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -10)
])
```
after:
```
let viewInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
view.pinToSuperview(with: viewInsets)
```
pinToSuperview method overloaded by AutoLayoutSugar with default insets equals .zero., and we can use this feature like that:
before:
```
NSLayoutConstraint.activate([
	view1.topAnchor.constraint(equalTo: superview.topAnchor),
	view1.leftAnchor.constraint(equalTo: superview.leftAnchor),
	view1.rightAnchor.constraint(equalTo: superview.rightAnchor),
	view1.bottomAnchor.constraint(equalTo: superview.bottomAnchor)
])
```
after:
```
view1.pinToSuperview()
```
AutoLayoutSugar provides pinning all sides excluded one with/without insets:
before:
```
NSLayoutConstraint.activate([
	view1.topAnchor.constraint(equalTo: superview.topAnchor),
	view1.leftAnchor.constraint(equalTo: superview.leftAnchor),
	view1.rightAnchor.constraint(equalTo: superview.rightAnchor)
])
```
after:
```
view1.pin(excluding .bottom)
```
AutoLayoutSugar provides pinning certain sides:
before:
```
NSLayoutConstraint.activate([
	view1.topAnchor.constraint(equalTo: superview.topAnchor),
	view1.leftAnchor.constraint(equalTo: superview.leftAnchor)
])
```
after:
```
view1.pin([.top, .left])
```
All pinning methods has relatedView argument, `nil` by default and equals to superview. But if needed, we can set related view like this:
```
view1.pin([.top, .left], to: view2)
```
Remember: Related view should has one parent superview with current operated view.

##### Enabling safe area API
If we have any reasons to use safe areas in our layout logic, AutoLayoutSugar provides closure-based API:
```swift
collectionView.left().right().safeArea { $0.top().bottom(10) }
```
Remember: Use only AutoLayoutSugar chained methods in this closure, because third-party methods calling in this place has no layout effect.

### Layout example
<p align="center">
  <img src="https://i.imgur.com/0csygci.png" width="250">
</p>

before:
```
let superView = UIView()
let leftView = UIView()
let rightView = UIView(
let bottomView = UIView()

[leftView, rightView, bottomView].forEach { 
	$0.translatesAutoresizingMaskIntoConstraints = false
	superView.addSubview($0) 
}
superView.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
	leftView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 10),
	leftView.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 10),
	leftView.rightAnchor.constraint(equalTo: rightView.leftAnchor, constant: -20),
	leftView.heightAnchor.constraint(equalToConstant: 25),
	leftView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -15),

	rightView.widthAnchor.constraint(equalTo: leftView.widthAnchor),
	rightView.topAnchor.constraint(equalTo: superView.topAnchor, constant: 10),
	rightView.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -10),
	rightView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: -15),

	bottomView.leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 10),
	bottomView.rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -10),
	bottomView.bottomAnchor.constraint(equalTo: superView.bottomAnchor)
])
```
after:
```
let superView = UIView().prepareForAutoLayout()
let leftView = UIView().prepareForAutoLayout()
let rightView = UIView().prepareForAutoLayout()
let bottomView = UIView().prepareForAutoLayout()

[leftView, rightView, bottomView].forEach { superView.addSubview($0) }
leftView.width(as: rightView).height(25).top(10).left(10).right(to: .left(20), of: rightView).bottom(to: .top(15), of: bottomView)
rightView.top(10).right(10).bottom(to: .top(15), of: bottomView)
bottomView.left(10).right(10).bottom()
```
##### More example
```swift
switcher.centerY().left(8)

label.centerY().centerX()

button
   .left(to: .right(20), of: label)
   .top(to: switcher)
   .right(24)
```
<p align="left">
  <img src="https://i.imgur.com/X0w6WIS.png" width="400">
</p>


