//
//  FirstViewController.swift
//  BluetoothSDK
//
//  Created by Jesse on 2019/11/18.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

public class FirstViewController: UIViewController {
    
    public init(withCourseId cId: String) {
        super.init(nibName: nil, bundle: nil)
        
        let currentBundle = Bundle.init(for: FirstViewController.self)
//        let bundlePath = Bundle.main.path(forResource: "Frameworks/BluetoothSDK.framework/Bluetooth", ofType: "bundle")
//        let BluetoothSDKBundle = Bundle.init(path: bundlePath!)
        let storyBoard = UIStoryboard.init(name: "FirstViewController", bundle: currentBundle)
        storyBoard.instantiateInitialViewController()
        
//        let listViewController = listv
        

        
//        courseId = cId
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    public required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        let storyBoard = UIStoryboard.init(name: String(describing: self), bundle: nil)
//        self = storyBoard.instantiateInitialViewController()
//    }

   public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
    

    @IBAction func scanAllAction(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanPeripheralViewController") as! ScanPeripheralViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func sacnQRAction(_ sender: UIButton) {
        //        let vc = UIStoryboard(name: "QRScanViewController", bundle: nil).instantiateInitialViewController()
//        let vc = QRScanViewController.init()
//        vc.scanResultBlock = {
//            if $0.count == 16 {
//                let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScanPeripheralViewController") as! ScanPeripheralViewController
//                vc.imie = $0;
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else{
//                self.showAlertViewController(message: "二维码信息有误请重新扫描！")
//            }
//        }
//        self.navigationController?.pushViewController(vc, animated: true)
    }

}


