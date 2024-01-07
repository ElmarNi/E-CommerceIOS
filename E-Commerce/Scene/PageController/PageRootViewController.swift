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
    private var count = 0
    private var currentIndex = 0
    private var fromHome = false
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if fromHome {
            for subView in view.subviews {
                if subView is UIPageControl {
                    view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: subView.frame.height + view.frame.height)
                    subView.frame = CGRect(x: view.frame.origin.x + 4,
                                           y: view.frame.height - (subView.frame.height * 3),
                                           width: subView.frame.width,
                                           height: subView.frame.height)
                    subView.layer.cornerRadius = 12
                    subView.clipsToBounds = true
                    subView.backgroundColor = UIColor(red: 0.96, green: 0.96, blue: 0.99, alpha: 1)
                }
            }
            
        }
    }
    
    func configureEntryPage(_ data: [EntryPage]) {
        for i in 0..<data.count {
            let pageViewController = EntryPageViewController()
            pageViewController.configure(data: data[i], index: i)
            pageViewController.delegate = self
            pages.append(pageViewController)
        }
        count = data.count
        configurePages()
    }
    
    func configureHomePage(_ data: [Product]) {
        for i in 0..<data.count {
            let pageViewController = HomePageViewController()
            pageViewController.configure(product: data[i])
            pages.append(pageViewController)
        }
        count = data.count
        configurePages()
        fromHome = true
    }
    
    private func configurePages() {
        guard pages.count > 0 else { return }
        setViewControllers([pages[0]], direction: .forward, animated: false, completion: nil)
        let proxy = UIPageControl.appearance()
        proxy.pageIndicatorTintColor = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1)
        proxy.currentPageIndicatorTintColor = UIColor(red: 0.03, green: 0.89, blue: 0.53, alpha: 1)
        currentIndex = 0
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
}

extension PageRootViewController: EntryPageViewControllerDelegate {
    func nextButtonTapped(index: Int) {
        guard index + 1 < pages.count else {
            return
        }
        
        currentIndex = index + 1
        self.setViewControllers([self.pages[index+1]], direction: .forward, animated: true, completion: nil)
    }
}
