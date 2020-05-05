//
//  RootTabBarController.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/27.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

class RootTabBarController: UIViewController {
    
    internal var rootTabBarController: UITabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(rootTabBarController)
        view.addSubview(rootTabBarController.view)
        
//        let mm = UITabBar.appearance()
//        mm.backgroundImage = #imageLiteral(resourceName: "tabbar_background_arc")
        let discoverNaviVC = NavigationController(rootViewController: DiscoverViewController())
        let mallNaviVC = NavigationController(rootViewController: LoginVC.instantiate())
        let travalNaviVC = NavigationController(rootViewController: BaseViewController())
        let vehicleNaviVC = NavigationController(rootViewController: BaseViewController())
        let mineNaviVC = NavigationController(rootViewController: BaseViewController())
        
        rootTabBarController.viewControllers = [discoverNaviVC, mallNaviVC, travalNaviVC, vehicleNaviVC, mineNaviVC] as [NavigationController]

        let tabBarItemConfigs = [
                                                ["发现","tabbar_discover_normal","tabbar_discover_selected"],
                                                ["商城","tabbar_mall_normal","tabbar_mall_selected"],
                                                ["旅行","tabbar_travel_normal","tabbar_travel_selected"],
                                                ["车辆","tabbar_vehicle_normal","tabbar_vehcile_selected"],
                                                ["我的","tabbar_profile_normal","tabbar_profile_selected"]
                                              ]
        guard tabBarItemConfigs.count == rootTabBarController.viewControllers?.count else {
            return
        }
        
        let configItem: (UITabBarItem, [String]) -> Void = {(item: UITabBarItem, config: [String]) -> Void in
            item.title = config[0]
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
            item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.green], for: .selected)
            item.image = UIImage(named: config[1])?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
            item.selectedImage = UIImage(named: config[2])?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
           
        }
        
        rootTabBarController.viewControllers?.enumerated().forEach({ (index, vc) in
            if let vc = vc as? NavigationController {
                vc.navigationBar.isTranslucent = false
                configItem(vc.tabBarItem, tabBarItemConfigs[index])
            }
        })
        
       
    }
    
}
