//
//  BoutiqueVC.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/28.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import UIKit

internal final class BoutiqueVC: BaseViewController {
    
    var viewModel: BoutiqueVM!
//    var flowLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        return layout;
//    }()
    
    var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.scrollDirection = .vertical
//        flowLayout.itemSize = CGSize(width: 414, height: 100)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib.init(nibName: "BoutiquePostCell", bundle: nil), forCellWithReuseIdentifier: "BoutiquePostCell")
        collectionView.refreshControl = UIRefreshControl()
        collectionView.refreshControl?.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.backgroundColor = .purple
        
        collectionView.refreshControl?.beginRefreshing()
        refreshAction(nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
    
    // MARK: Private Method
     @objc private func refreshAction(_ sender: AnyObject?) {
        if collectionView.refreshControl!.isRefreshing {
//            collectionView.refreshControl?.attributedTitle = NSAttributedString(string: "刷新中...")
            viewModel.fetchData(lastPostId: "0", size: 20) {
                self.collectionView.refreshControl?.endRefreshing()
                self.collectionView.reloadData()
                
            }
        }
        
    }
}

extension BoutiqueVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dataList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BoutiquePostCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BoutiquePostCell", for: indexPath) as! BoutiquePostCell
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = .gray
        }else {
            cell.backgroundColor = .white
        }
        cell.model = viewModel.dataList[indexPath.item] as? PostModel
        return cell
    }
}

extension BoutiqueVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let cha = scrollView.contentSize.height - offsetY - scrollView.bounds.height
        if cha > 0, cha < 60, let model = viewModel.dataList.last {
            let post = model as! PostModel
            viewModel.fetchData(lastPostId: post.id!, size: 20) {
                
                self.collectionView.reloadData()
                
            }
        }
    }
}

extension BoutiqueVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension BoutiqueVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 300)
    }
}
