//
// Project: PageViewer
// File: PageViewerView.swift
// Created by: Egor Boyko
// Date: 21.10.2022
//
// Status: #In progress | #Not decorated
//
import SwiftUI


struct PageViewerComponent<A: RandomAccessCollection, C: View>: View {
    
    //----------public
    public init(_ array: A, currentIndex: Binding<Int>, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.init(array, currentIndex: currentIndex, currentPage: nil, content: content)
    }
    public init(_ array: A, currentPage: Binding<Int>, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: currentPage, content: content)
    }
    public init(_ array: A, currentIndex: Binding<Int>, @ViewBuilder content: @escaping (A.Element) -> C){
        self.init(array, currentIndex: currentIndex, currentPage: nil, content: content)
    }
    public init(_ array: A, currentPage: Binding<Int>, @ViewBuilder content: @escaping (A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: currentPage, content: content)
    }
    public init(_ array: A, @ViewBuilder content: @escaping (A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: nil, content: content)
    }
    public init(_ array: A, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.init(array, currentIndex: nil, currentPage: nil, content: content)
    }
    //----------private
    private init(_ array: A, currentIndex: Binding<Int>? = nil, currentPage: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Index, A.Element) -> C){
        self.views = Array(zip(array.indices, array)).map { (index, element) in
            content(index, element)
        }
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        if currentIndex == nil && currentPage == nil {
            self._indexToPoint = State(initialValue: 0)
        } else {
            self._indexToPoint = nil
        }
    }
    private init(_ array: A, currentIndex: Binding<Int>? = nil, currentPage: Binding<Int>? = nil, @ViewBuilder content: @escaping (A.Element) -> C){
        self.views = Array(array).map { content($0) }
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        if currentIndex == nil && currentPage == nil {
            self._indexToPoint = State(initialValue: 0)
        } else {
            self._indexToPoint = nil
        }
    }
    
    private let _indexToPoint: State<Int>?
    private let currentIndex: Binding<Int>?
    private let currentPage: Binding<Int>?
    private let views: [C]
    
    var indexToPoint: Int {
        if currentIndex != nil {
            return currentIndex!.wrappedValue
        } else if currentPage != nil {
            return currentPage!.wrappedValue - 1
        } else {
            return _indexToPoint?.wrappedValue ?? 0
        }
    }
    
    private func getPoint(border: Color, fill: Color) -> some View {
        ZStack{
            Circle()
                .fill(border)
            Circle()
                .fill(fill)
                .padding(1)
        }
        .frame(width: 20, height: 20)
    }
    
    var body: some View {
        PageViewerWrapper(views, currentIndex, currentPage)
        HStack{
            ForEach(0..<views.count){ item in
                self.getPoint(border: .black, fill: currentIndex?.wrappedValue == item ? .gray : .white)
            }
        }
    }
    
    @ViewBuilder var viewer: some View {
        if currentIndex == nil && currentPage == nil {
            PageViewerWrapper(views, self.$_indexToPoint, nil)
        }
    }
    
}

extension PageViewerComponent where A == [Any] {
    init(views: [C], currentIndex: Binding<Int>){
        self.views = views
        self.currentIndex = currentIndex
        self.currentPage = nil
        self._indexToPoint = nil
    }
    init(views: [C], currentPage: Binding<Int>){
        self.views = views
        self.currentIndex = nil
        self.currentPage = nil
    }
    init(views: [C]){
        self.views = views
        self.currentIndex = nil
        self.currentPage = nil
        self._indexToPoint = State(initialValue: 0)
    }
}

fileprivate struct PageViewerWrapper<T>: UIViewControllerRepresentable where T : View{
    
    let views: [T]
    let currentIndex: Binding<Int>?
    let currentPage: Binding<Int>?
    
    init(_ views: [T], _ currentIndex: Binding<Int>?, _ currentPage: Binding<Int>?) {
        self.views = views
        self.currentIndex = currentIndex
        self.currentPage = currentPage
    }
    
    internal func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator
        if let root = context.coordinator.root {
            pageViewController.setViewControllers(
                [root], direction: .forward, animated: true)
        }
        return pageViewController
    }
    
    func makeCoordinator() -> PagesViewerCoordinator<T> {
        PagesViewerCoordinator(views, currentIndex, currentPage)
    }
    
    func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
        let last: Int,
            count: Int,
            direction: UIPageViewController.NavigationDirection
        var index: Int
        
        if let currentIndex = self.currentIndex?.wrappedValue {
            index = currentIndex
        } else if let currentPage = self.currentPage?.wrappedValue {
            index = currentPage - 1
        } else {
            return
        }
        
        count = context.coordinator.controllers.count
        last = context.coordinator.lastIndex
        
        
        if index >= count && last < count  {
            print("Индекс или Номер страницы вышли за допустимые пределы")
            self.currentPage?.wrappedValue = 1
            self.currentIndex?.wrappedValue = 0
            index = 0
        }
        
        direction = index > last ? .forward : .reverse
        if last == index { return }
        
        context.coordinator.lastIndex = index
        pageViewController.setViewControllers(
            [context.coordinator.controllers[index]], direction: direction, animated: true)
    }

}

fileprivate final class CustomUIHostingController<Content>: UIHostingController<Content> where Content: View {
    var index: Int
    init(index: Int, rootView: Content) {
        self.index = index
        super.init(rootView: rootView)
    }
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

fileprivate final class PagesViewerCoordinator<T>: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate where T:View {
    
    let controllers: [CustomUIHostingController<T>]
    let root: CustomUIHostingController<T>?
    let currentIndex: Binding<Int>?
    let currentPage: Binding<Int>?
    var lastIndex: Int
    
    init(_ views: [T], _ currentIndex: Binding<Int>?, _ currentPage: Binding<Int>?) {
        var temp: [CustomUIHostingController<T>] = []
        for (index, element) in views.enumerated() {
            temp.append(CustomUIHostingController(index: index, rootView: element))
        }
        
        self.controllers = temp
        self.currentIndex = currentIndex
        self.currentPage = currentPage
        self.root = controllers.first
        self.lastIndex = currentIndex?.wrappedValue ?? ((currentPage?.wrappedValue ?? 1) - 1)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? CustomUIHostingController<T>
            else {
                return nil
            }
            let index = hosting.index == 0 ? controllers.count - 1 : hosting.index - 1
            self.lastIndex = index
            return controllers[index]
    }
    
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard
                let hosting = viewController as? CustomUIHostingController<T>
            else {
                return nil
            }
            let index = hosting.index + 1 == controllers.count ? 0 : hosting.index + 1
            self.lastIndex = index
            return controllers[index]
        }
    
    
    internal func pageViewController(
        _ pageViewController: UIPageViewController,
        didFinishAnimating finished: Bool,
        previousViewControllers: [UIViewController],
        transitionCompleted completed: Bool) {
            
            if self.currentIndex == nil && currentPage == nil { return }
            
            guard
                let hosting = pageViewController.viewControllers?.first as? CustomUIHostingController<T>
            else {
                return
            }
            
            self.currentIndex?.wrappedValue = hosting.index
            self.currentPage?.wrappedValue = hosting.index + 1

        }
}
