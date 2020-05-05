

import Foundation
import UIKit

public struct Extension<Base> {
    var base: Base
    
    init(_ base: Base) {
        self.base = base
    }
}

protocol Extendable {
    
}

extension Extendable {
    var ex: Extension<Self> {
        set {}
        get {
            return Extension(self)
        }
    }
    
    static var ex: Extension<Self>.Type {
        set {}
        get {
            return Extension.self
        }
    }
}

extension NSObject: Extendable {}


public struct Border {
    public enum Edge: CaseIterable {
        case leading
        case trailing
        case top
        case bottom
    }
    
    let edge: Edge
    let width: CGFloat
    let color: UIColor
    let leading: CGFloat
    let trailing: CGFloat
    
    public init(
        edge: Edge,
        width: CGFloat = 1.0 / UIScreen.main.scale,
        color: UIColor = UIColor(red: 200/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1),
        leading: CGFloat = 0,
        trailing: CGFloat = 0
        ) {
        self.edge = edge
        self.width = width
        self.color = color
        self.leading = leading
        self.trailing = trailing
    }
}

@available(iOS 9.0, *)
extension Extension where Base: UIView {
    @discardableResult
    public func activeBoard(border: Border) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        base.backgroundColor = .clear
        base.addSubview(view)
        
        switch border.edge {
        case .top:
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: border.width),
                view.topAnchor.constraint(equalTo: base.topAnchor),
                view.leadingAnchor.constraint(equalTo: base.leadingAnchor, constant: border.leading),
                view.trailingAnchor.constraint(equalTo: base.trailingAnchor, constant: -border.trailing)
                ])
        case .leading:
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: border.width),
                view.leadingAnchor.constraint(equalTo: base.leadingAnchor),
                view.topAnchor.constraint(equalTo: base.topAnchor, constant: border.leading),
                view.bottomAnchor.constraint(equalTo: base.bottomAnchor, constant: -border.trailing)
                ])
        case .bottom:
            NSLayoutConstraint.activate([
                view.heightAnchor.constraint(equalToConstant: border.width),
                view.bottomAnchor.constraint(equalTo: base.bottomAnchor),
                view.leadingAnchor.constraint(equalTo: base.leadingAnchor, constant: border.leading),
                view.trailingAnchor.constraint(equalTo: base.trailingAnchor, constant: -border.trailing)
                ])
        case .trailing:
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: border.width),
                view.trailingAnchor.constraint(equalTo: base.trailingAnchor),
                view.topAnchor.constraint(equalTo: base.topAnchor, constant: border.leading),
                view.bottomAnchor.constraint(equalTo: base.bottomAnchor, constant: -border.trailing)
                ])
        }
        return view
    }
}
