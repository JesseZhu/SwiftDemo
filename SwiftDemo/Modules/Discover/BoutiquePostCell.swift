//
//  BoutiquePostCell.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/11/28.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class BoutiquePostCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var likeImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var timeLineLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var readCountLabel: UILabel!
    @IBOutlet weak var likeCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        coverImageView.contentMode = .scaleAspectFill
        avatarImageView.contentMode = .scaleAspectFill
        contentLabel.textColor = .white
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        contentView.ex.activeBoard(border: .init(edge: .bottom, width: 0.5, color: .red, leading: 15, trailing: 15))
        contentView.ex.activeBoard(border: .init(edge: .top, width: 0.5, color: .blue, leading: 0, trailing: 0))
        contentView.ex.activeBoard(border: .init(edge: .leading, width: 0.5, color: .red, leading: 15, trailing: 15))
        contentView.ex.activeBoard(border: .init(edge: .trailing, width: 0.5, color: .purple, leading: 15, trailing: 15))
    }
    
    var model: PostModel! {
        didSet{
            let img = model.imgs?[0]
            let avatorUrlString = model.author!.avatorUrl!
            avatarImageView.kf.setImage(with: URL(string: avatorUrlString))
            coverImageView.kf.setImage(with: URL(string: img!.url!))
            nickNameLabel.text = model.author?.name
            timeLineLabel.text = DateFormatter.mdhm.string(from: Date(timeIntervalSince1970: model.createTime!))
            contentLabel.text = model.title
            readCountLabel.text = "浏览 " + String(model.readCount!)
            likeCountLabel.text = String(model.likeCount!)
            
        }
    }
    
    override func updateConstraints() {
        
        super .updateConstraints()
    }

}


extension UIView {
    typealias UIViewTapClosure = (() -> ())
    
    fileprivate struct TapAssociatedKeys {
        static var kWhenLongPressBlockKey = "kWhenLongPressBlockKey"
        static var kWhenTappedBlockKey = "kWhenTappedBlockKey"
        static var kWhenDoubleTappedBlockKey = "kWhenDoubleTappedBlockKey"
        static var kWhenTwoFingerTappedBlockKey = "kWhenTwoFingerTappedBlockKey"
        static var kWhenTouchedDownBlockKey = "kWhenTouchedDownBlockKey"
        static var kWhenTouchedUpBlockKey = "kWhenTouchedUpBlockKey"
    }
    
    func setBlock(tapClosure: UIViewTapClosure, key: UnsafeRawPointer) {
        self.isUserInteractionEnabled = true
//        objc_setAssociatedObject(self, key, tapClosure, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
    }

    func taped(_ taped: (() -> ())) {
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(tap))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tap() {
        
    }
    
}
