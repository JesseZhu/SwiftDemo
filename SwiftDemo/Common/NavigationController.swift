//
//  RootNavigationController.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/27.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    // MARK: Life-cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count >= 1 {
             viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    // MARK: Override
    override var shouldAutorotate: Bool {
        return topViewController?.shouldAutorotate ?? false
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return topViewController?.supportedInterfaceOrientations ?? .portrait
    }

    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
    
    override var childForStatusBarHidden: UIViewController? {
        return topViewController
    }

}



