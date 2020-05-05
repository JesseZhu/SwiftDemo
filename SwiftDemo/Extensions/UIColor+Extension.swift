import Foundation
import UIKit

extension UIColor {
    public convenience init(r red: UInt, g green: UInt, b blue: UInt, a alpha: CGFloat = 1.0) {
        let red   = CGFloat(red) / 255.0
        let green = CGFloat(green) / 255.0
        let blue  = CGFloat(blue) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// 0x3300cc or 0x30c
    public convenience init(hex: UInt32, alpha: CGFloat = 1) {
        let short = hex <= 0xfff
        let divisor: CGFloat = short ? 15 : 255
        let red   = CGFloat(short  ? (hex & 0xF00) >> 8 : (hex & 0xFF0000) >> 16) / divisor
        let green = CGFloat(short  ? (hex & 0x0F0) >> 4 : (hex & 0xFF00)   >> 8)  / divisor
        let blue  = CGFloat(short  ? (hex & 0x00F)      : (hex & 0xFF))           / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// #3300cc or #30c
    public convenience init(hex: String, alpha: CGFloat = 1) {
        // Convert hex string to an integer
        var hexint: UInt32 = 0
        
        // Create scanner
        let scanner = Scanner(string: hex)
        
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexint)
        
        self.init(hex: hexint, alpha: alpha)
    }
}
