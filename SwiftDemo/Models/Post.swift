//
//  Post.swift
//  SwiftDemo
//
//  Created by Jesse on 2019/12/1.
//  Copyright © 2019 Jesse.Zhu. All rights reserved.
//

import Foundation
import HandyJSON

class PostModel: HandyJSON {
    let id: String? = nil
    let topic: String? = nil
    let title: String? = nil
    let popular: Bool? = nil
    let official: Bool? = nil
    let location: String? = nil
    let deleted: Bool? = nil
    let replyCount: Int? = nil
    let shareCount: Int? = nil
    let likeCount: Int? = nil
    let readCount: Int? = nil
    let createTime: TimeInterval? = nil
    let updateTime: TimeInterval? = nil
    let checked: Bool? = nil
    let answer: String? = nil
    let answerTime: String? = nil
    let author: AuthorModel? = nil
    let imgs: [ImageModel]? = nil
    
    required init() {}
}
