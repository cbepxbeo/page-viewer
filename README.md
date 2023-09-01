# PageViewer

UIPageViewController adapted for use in SwiftUi AnyView

## Version 2.0.0 changes
- Reactive modifiers
- New display and transition logic
- Delegate to receive events
- External controller for software control of transitions
- You can independently determine which safe areas to ignore and which not
- Full control over the appearance of indicators
- Gesture lock
- AnyView is no longer used when creating an array of views for a UIPageViewController
- Added documentation with examples
- Fixed crash of simultaneous navigation with gesture when changing index via anchor
- Fixed loss of Binding on multiple new values at times completed
- Limited transitions when multiple assigning a new value to the Binding index (if you quickly tap on the button that changes the index), which could lead to crashes

## Version 2.0.1 changes
- Lazy View Optimization
- Fixed a bug that caused an extra render when enabling/disabling scroll reactively

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

Once you have your Swift package set up, adding PageViewer as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/cbepxbeo/page-viewer.git", .upToNextMajor(from: "0.0.1"))
]
```

## Usage

If you don't want to, then there is no need to create your own providers. the package provides everything you need by default.

### Generating a View with Binding from a collection using an index and an element.
```swift
 @State var index: Int = 0
 let collection: [Int] = [1,2,3,4,5]

 var body: some View {
     PageView(collection, index: $index) { index, element in
         VStack {
             Text("Element: \(element)")
             Text("Index: \(index)")
         }
     }
 }       
```

### Generating a View without Binding from a collection using an index and an element.
```swift
let collection: [Int] = [1,2,3,4,5]

var body: some View {
    PageView(collection) { index, element in
        VStack {
            Text("Element: \(element)")
            Text("Index: \(index)")
        }
    }
}
```     

### Generating a View with Binding from a collection using an element.
```swift
 @State var index: Int = 0
 let collection: [Int] = [1,2,3,4,5]

 var body: some View {
     PageView(collection, index: $index) { element in
         VStack {
             Text("Element: \(element)")
         }
     }
 }
```     

### Generating a View without Binding from a collection using an element.
```swift
 let collection: [Int] = [1,2,3,4,5]

 var body: some View {
     PageView(collection) { element in
         VStack {
             Text("Element: \(element)")
         }
     }
 }
```     

### Create from ready-made representations in an array with Binding
```swift
 @State var index: Int = 0

 let array: [Color] = [
     .red,
     .blue,
     .green
 ]

 var body: some View {
     PageView(views: array, index: $index)
 }
```     

### Create from ready-made representations in an array without Binding
```swift
 let array: [Color] = [
     .red,
     .blue,
     .green
 ]

 var body: some View {
     PageView(views: array)
 }
```  

If you are using full screen output, then you need to specify it for the required views.

```swift
 let collection: [Int] = [1,2,3,4,5]

 var body: some View {
     PageView(collection) { index, element in
         if index == 0 {
             ZStack {
                 Color.red
                 Text("Element: \(element)")
             }
             .ignoresSafeArea() //Will ignore
         } else {
             ZStack {
                 Color.green
                 Text("Element: \(element)")
             } //Will not
         }
     }
 }
```  

You can take full advantage of the ViewBuilder and create unique views for each element

```swift
 @State var index: Int = 0
 let collection: [Int] = [1,2,3,4,5]

 var body: some View {
     PageView(collection, index: $index) { element in
         if element == 1 {
             ZStack{
                 Color.red
                 Text("First")
             }
         } else {
             Text("Other element. Element: \(element)")
         }
     }
 }
```  

### Set and create delegate

```swift
 final class ExampleViewModel: ObservableObject, PageViewDelegate {
     //Required by a delegate
     func willTransition(_ pendingIndex: Int) {
         //Your code
     }
     //Required by a delegate
     func didFinishAnimating(_ completed: Bool) {
         //Your code
     }
     //Required by a delegate
     func indexAfterAnimation(_ index: Int) {
         //Your code
     }
 }
 struct ExampleView: View {
     @StateObject var viewModel = ExampleViewModel()
     let collection: [Int] = [1,2,3,4,5]

     var body: some View {
         PageView(collection) {  element in
             Text("Element: \(element)")
         }
         .delegate(self.viewModel)
     }
 }
```  

Use a delegate to access the actual index.

```swift
     final class ExampleViewModel: ObservableObject, PageViewDelegate {
         //Required by a delegate
         func willTransition(_ pendingIndex: Int) {
             //Your code
         }
         //Required by a delegate
         func didFinishAnimating(_ completed: Bool) {
             //Your code
         }

         //Property to store index and view notifications
         @Published
         var currentIndex: Int = 0

         //Delegate method that receives the index after the transition animation.
         //Runs on the main thread
         func indexAfterAnimation(_ index: Int) {
             self.currentIndex = index
         }

     }
     struct ExampleView: View {
         @StateObject var viewModel = ExampleViewModel()
         @State var index: Int = 0 //Do not use for state control in modifiers
         let collection: [Int] = [1,2,3,4,5]

         var body: some View {
             PageView(collection, index: $index) { index, element in
                 ZStack {
                     Color.red
                     if index != 1 {
                         Text("Element: \(element)")
                     } else {
                         //Appears in a view with scroll disabled and allows
                         //you to navigate to the next view
                         Button("Go to view at index 2"){
                             self.index = 2 //You can assign for switching
                         }
                     }
                 }
             }
             .delegate(self.viewModel) //Installing a delegate
             //Disable scroll gestures for view at index 1
             .scrollEnabled(self.viewModel.currentIndex != 1) //Correct
             //.scrollEnabled(self.index != 1) Wrong
         }
     }
```  

### Set and create external controller

```swift
 final class ExampleViewModel: ObservableObject, PageViewController {
     //Required by a controller
     var pageViewCoordinator: CoordinatorStorage?
 }
 struct ExampleView: View {
     @StateObject var viewModel = ExampleViewModel()
     let collection: [Int] = [1,2,3,4,5]

     var body: some View {
         VStack{
             PageView(collection, index: $index) {  element in
                 Text("Element: \(element)")
             }
             .controller(self.viewModel)
             Button("Go to next"){
                 self.viewModel.go(to: .next)
             }
             //The go method is provided by default
         }
     }
 }
```  

### Setting indicators

```swift
 struct ExampleIndicatorsStyle: IndicatorStyle {
     func makeIndicator(selected: Bool, index: Int) -> some View {
         Circle()
             .fill(selected ? .red : .green)
             .frame(width: 30, height: 30)
     }
     func makeConfiguredPageView(
         content: () -> Content,
         indicators: () -> Indicators) -> some View {
             VStack{
                 content()
                 HStack{
                     indicators()
                 }
                 .padding(.top, 50)
             }
     }
 }

 struct ExampleView: View {
     let collection: [Int] = [1,2,3,4,5]
     var body: some View {
         PageView(collection) {  element in
             Text("Element: \(element)")
         }
         .indicators(ExampleIndicatorsStyle())
     }
 }
``` 

### Note
More information is documented in the package.

<img src="https://github.com/cbepxbeo/resorces/blob/9badb0580e0556bc276b111d382d53deac7c67f8/resources/page-viewer/media/build_documentation.gif" alt="PageViewer (Build Documentation)">   

<img src="https://github.com/cbepxbeo/resorces/blob/9badb0580e0556bc276b111d382d53deac7c67f8/resources/page-viewer/media/show_hint.gif" alt="PageViewer (Build Documentation)">
