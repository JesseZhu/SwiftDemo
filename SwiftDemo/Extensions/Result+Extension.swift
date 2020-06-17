//
//  Result+Extension.swift
//  SwiftDemo
//
//  Created by Jesse on 2020/5/25.
//  Copyright © 2020 Jesse.Zhu. All rights reserved.
//

import Foundation

public protocol ResultConvertible {
    associatedtype Success
    associatedtype Failure: Swift.Error
    
    var result: Swift.Result<Success, Failure> { get }
}

extension ResultConvertible {
    public var success: Success? {
        switch result {
            case let .success(value): return value
            case .failure: return nil
        }
    }
    
    public var failure: Failure? {
        switch result {
            case .success: return nil
            case let .failure(error): return error
        }
    }
    
    public var isSuccess: Bool {
        switch result {
            case .success: return true
            case .failure: return false
        }
    }
    
    public var isFailure: Bool {
        return !isSuccess
    }
    
    public func  void() -> Swift.Result<Void, Failure> {
        return result.map{ _ in  }
    }
}

extension Swift.Result: ResultConvertible {
    public var result: Swift.Result<Success, Failure> {
        return self
    }
}

extension Swift.Result {
    public init(success: Success) {
        self = .success(success)
    }
    
    public init(failure: Failure) {
        self = .failure(failure)
    }
}
