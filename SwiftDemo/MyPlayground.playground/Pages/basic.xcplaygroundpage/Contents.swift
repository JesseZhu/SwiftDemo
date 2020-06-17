//: [Previous](@previous)

import Foundation

enum BaseError: Swift.Error {
    case notFind
    case fetchFailed(msg: String)
}

extension BaseError: CustomNSError {
    var errorDescription: String? {
        switch self {
            case .notFind:
            return NSLocalizedString("A user-friendly description of the error.", comment: "My error")
            case .fetchFailed(let msg):
            return NSLocalizedString(msg, comment: "My error")
        }
    }
}
let error: BaseError = .notFind
print(1234)
print(error.localizedDescription)

//: [Next](@next)
