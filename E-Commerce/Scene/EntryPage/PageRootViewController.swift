//
//  PageRootViewController.swift
//  E-Commerce
//
//  Created by Elmar Ibrahimli on 05.12.23.
//

import UIKit
import SnapKit

class PageRootViewController: UIPageViewController {
    private var pages: [UIViewController] = [UIViewController]()
    private var currentPageIndex = 0
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self
        for i in 0..<3 {
            let pageViewController = PageViewController()
            pageViewController.configure(index: i)
            pageViewController.delegate = self
            pages.append(pageViewController)
        }
        
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        proxy.currentPageIndicatorTintColor = UIColor(red: 0.03, green: 0.89, blue: 0.53, alpha: 1)
    }
    
}

extension PageRootViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let previousIndex = viewControllerIndex - 1
        guard pages.count > previousIndex, previousIndex >= 0 else { return nil }
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = pages.firstIndex(of: viewController) else { return nil }
        let nextIndex = viewControllerIndex + 1
        guard nextIndex < pages.count, pages.count > nextIndex else { return nil }
        return pages[nextIndex]
    }
    
}

extension PageRootViewController: UIPageViewControllerDelegate {
    
//    func presentationCount(for pageViewController: UIPageViewController) -> Int {
//        return 3
//    }
//    
//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return 0
//    }
    
}

extension PageRootViewController: PageViewControllerDelegate {
    
    func nextButtonTapped(index: Int) {
        self.setViewControllers([self.pages[index+1]], direction: .forward, animated: true, completion: nil)
    }
    
}
