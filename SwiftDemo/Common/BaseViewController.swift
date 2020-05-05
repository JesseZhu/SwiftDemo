//
//  BaseViewController.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/4.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit
import SwiftyJSON
import SnapKit
import RxCocoa
import RxSwift
import Alamofire
import RxAlamofire
//import BluetoothSDK

class BaseViewController: UIViewController {
    
    fileprivate lazy var requestButton: UIButton = {
        var btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("request", for: .normal)
        btn.backgroundColor = .red
        return btn
    }()

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        let vc = FirstViewController.init(withCourseId: "fff")
//        self.navigationController?.pushViewController(vc, animated: true)
        self.navigationController?.pushViewController(BaseViewController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Next"
        
        view.backgroundColor = .white
        navigationController?.delegate = self
        
//        let testButton = UIButton.init(type: .system)
//        testButton.setTitle("test", for: .normal)
//        testButton.backgroundColor = .purple
//        view.addSubview(testButton)
//
//        let beizerPatha = UIBezierPath.init(roundedRect: CGRect.init(x: 0, y: 0, width: 100, height: 50), byRoundingCorners: [UIRectCorner.topLeft,UIRectCorner.bottomLeft]  , cornerRadii: CGSize(width: 25, height: 25))
//
//        let mask = CAShapeLayer.init()
//        mask.path = beizerPatha.cgPath
//        mask.fillColor = UIColor.black.cgColor
//        mask.strokeColor = UIColor.yellow.cgColor
//        testButton.layer.mask = mask
//
//        testButton.snp.makeConstraints { (maker) in
//            maker.center.equalTo(self.view.center)
//            maker.width.equalTo(100)
//            maker.height.equalTo(50)
//        }
        
//        HTTPManager.shared.queryTrffic(parameters: PIORequest.QueryTrafficParamters(coordType: "bd09ll", appid: "nng0013", radius: 1000, longitude: 121.41170722609854, latitude: 31.235829383896117), success: { (dict) in
//
//        }) { (erro) in
//
//        }
        
//        self.view.addSubview(requestButton)
//        requestButton.snp.makeConstraints { (make) in
//            make.width.height.equalTo(100)
//            make.center.equalTo(self.view).offset(10)
//        }
    
        _ = BehaviorRelay<String>(value: "Test")
        
//        usernameval.bind(to: rx[{(_, str) in
//            print(str)
//        }])
        
       _ =  requestButton.rx.tap.subscribe(onNext: { (btn) in
            let urlStr = "http://47.92.171.223:18787/jaccount/login"
            let url = URL.init(string: urlStr)
            var sessionMrg = Alamofire.SessionManager.default 
        _ = sessionMrg.rx.request(urlRequest: URLRequest(url: url!)).flatMap{ (dataR) -> Observable<(HTTPURLResponse, Data)>  in
            dataR.rx.responseData()
        }.flatMap{ (response, data) -> Observable<Swift.Result<Model, Swift.Error>> in
            let statusCode = response.statusCode
            if statusCode == 200 {
                let json = JSON(data)
                print(json)
            }
            _ = try JSON.init(data: data, options: .allowFragments)
//            return .just(.success(Model(json: json)));
            return .error(NSError.init(domain: "", code: 1002, userInfo: nil))
        }
//            sessionMrg.rx.request(.post, urlStr).flatMap({ (dataR) -> ObservableConvertibleType in
//            return nil
//        })
        Alamofire.request(urlStr, method: .post,parameters: ["username":"13916646644","password":"1qaz2wsx"], headers:["agent":"ios"]).responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    print(json)
                    break
                case .failure(let error):
                    print("error:\(error)")
                    break
                }
            }
        })//.disposed(by: DisposeBag())
        
        let jsonStr = "[ {\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        if let jsonData = jsonStr.data(using: String.Encoding.utf8) {
            let obj = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [[String: AnyObject]]
            print(obj!)
            _ = Optional<Int>.some(3)
            _ = Optional<String>.some("fff")
            let json = try! JSON(data: jsonData)
            if let number = json[0]["phones"][0]["number"].string {
                // 找到电话号码
                print("第一个联系人的第一个电话号码：",number)
            }
        }
        
        
        
        let ob = Observable<Any>.create { (obserber) -> Disposable in
            obserber.onNext("发送")
            obserber.onError(NSError.init(domain: "falure", code: 1001, userInfo: nil))
            obserber.onCompleted()
            return Disposables.create()
        }
        
        _ = ob.subscribe(onNext: { (text) in
            print("接受到：\(text)")
        }, onError: { (err) in
            print(err)
        }, onCompleted: {
            print("完成")
        }) {
            print("销毁")
        }
    }


}

extension BaseViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
}
