//
//  BoutiqueVM.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/28.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

class BoutiqueVM: ViewModel {
    let pageSize: Int = 20
    
    override init() {
        
    }
    
    func fetchData(lastPostId: String = "0", size: Int = 20, completion: @escaping (() -> Void))  {
        HTTPManager.shared.queryPopularPosts(lastPostId: lastPostId, size: size) { (result) in
            switch result {
            case .success(let dataArray):
                if lastPostId == "0" {
                   self.dataList = dataArray
                }else {
                    self.dataList.append(contentsOf: dataArray)
                }
                completion()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadMoreData()  {
        if let model = dataList.last {
            let post = model as! PostModel
            fetchData(lastPostId: post.id!) {
                
            }
        }
        
    }
    
    func refreshData() {
        fetchData {
            
        }
    }

    
}
