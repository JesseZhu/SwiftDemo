//
//  PageContainerController.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/27.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit
import Foundation
import Parchment

class PageContainerController: BaseViewController {
    var viewControllers: [UIViewController]!
    
    var indicatorClass: PagingIndicatorView.Type = CustomIndicatorView.self
    
    // MARK: Page config
    var menuItemSize: PagingMenuItemSize = .fixed(width: 70, height: 40)
    var menuItemColor: UIColor = UIColor.init(hex: "#6C6C6C")
    var menuItemSeletedColor: UIColor = UIColor.init(hex: "#333642")
//    var pagingViewController: FixedPagingViewController = {
//        let pageVC = FixedPagingViewController.init(viewControllers: viewControllers)
//        return pageVC
//    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pagingViewController = PagingViewController(viewControllers: viewControllers)
        pagingViewController.menuItemSize = .fixed(width: 70, height: 40)
        pagingViewController.textColor = menuItemColor
        pagingViewController.selectedTextColor = menuItemSeletedColor
        pagingViewController.font = UIFont.systemFont(ofSize: 17)
        pagingViewController.selectedFont = UIFont.systemFont(ofSize: 20)
        pagingViewController.indicatorColor = .clear
        pagingViewController.indicatorClass = indicatorClass
//        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
//        pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
        addChild(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.didMove(toParent: self)
        pagingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pagingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pagingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pagingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pagingViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
            ])
    }

}

class CustomIndicatorView: PagingIndicatorView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(hex: "#333642")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    fileprivate func setup() {
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: topAnchor),
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineView.widthAnchor.constraint(equalToConstant: 14)
            ])
    }

}
