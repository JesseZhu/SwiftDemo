//
//  DiscoverViewController.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/27.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

class DiscoverViewController: PageContainerController {
    
    override func viewDidLoad() {
        let vc1 = BoutiqueVC()
        vc1.viewModel = BoutiqueVM()
        vc1.title = "精品"
        let vc2 = BaseViewController()
        vc2.title = "社区"
        let vc3 = BaseViewController()
        vc3.title = "咨询"
        let vc4 = BaseViewController()
        vc4.title = "回答"
        viewControllers = [vc1, vc2, vc3, vc4]
        super.viewDidLoad()
        
        
    }

}
