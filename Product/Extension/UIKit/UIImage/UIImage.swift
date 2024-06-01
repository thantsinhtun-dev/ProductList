//
//  UIImage.swift
//  Product
//
//  Created by Thant Sin Htun on 01/06/2024.
//

import Foundation
import UIKit

extension UIImage {
    /// Get the pixel color at a point in the image
    func pixelColor(atLocation point: CGPoint) -> UIColor? {
        guard let cgImage = cgImage, let pixelData = cgImage.dataProvider?.data else { return nil }

        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let bytesPerPixel = cgImage.bitsPerPixel / 8

        let pixelInfo: Int = ((cgImage.bytesPerRow * Int(point.y)) + (Int(point.x) * bytesPerPixel))

        let b = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let r = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}
extension UIColor {

    var coreImageColor: CIColor {
        return CIColor(color: self)
    }

    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        let coreImageColor = self.coreImageColor
        return (coreImageColor.red, coreImageColor.green, coreImageColor.blue, coreImageColor.alpha)
    }

    func isDarkColor() -> Bool {
        let luminate: CGFloat = 0.2126 * components.red + 0.7152 * components.green + 0.0722 * components.blue
        if luminate < 0.5 { return true }
        return false
    }

    func isDistinct(_ compareColor: UIColor) -> Bool {

        let (r, g, b, a) = components
        let (r1, g1, b1, a1) = compareColor.components

        let threshold1: CGFloat = 0.25
        guard abs(r - r1) > threshold1 ||
              abs(g - g1) > threshold1 ||
              abs(b - b1) > threshold1 ||
              abs(a - a1) > threshold1 else { return false }

        // check for grays, prevent multiple gray colors
        let threshold2: CGFloat = 0.03
        guard abs( r - g ) < threshold2 &&
              abs( r - b ) < threshold2 &&
              abs(r1 - g1) < threshold2 &&
              abs(r1 - b1) < threshold2 else { return true }

        return false
    }

    func color(withMinimumSaturation minSaturation: CGFloat) -> UIColor {

        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        if saturation < minSaturation {
            return UIColor(hue: hue, saturation: minSaturation, brightness: brightness, alpha: alpha)
        } else {
            return self
        }
    }

    func isBlackOrWhite() -> Bool {

        let (r, g, b, _) = components

        // isWhite
        if r > 0.91 &&
            g > 0.91 &&
            b > 0.91 {
            return true
        }

        // isBlack
        if r < 0.09 &&
            g < 0.09 &&
            b < 0.09 {
            return true
        }

        return false
    }

    func isContrastingColor(_ color: UIColor) -> Bool {

        let (r, g, b, _) = components
        let (r2, g2, b2, _) = color.components

        let bLum: CGFloat = 0.2126 * r + 0.7152 * g + 0.0722 * b
        let fLum: CGFloat = 0.2126 * r2 + 0.7152 * g2 + 0.0722 * b2

        var contrast: CGFloat = 0.0
        if bLum > fLum {
            contrast = (bLum + 0.05) / (fLum + 0.05)
        } else {
            contrast = (fLum + 0.05) / (bLum + 0.05)
        }
        //return contrast > 3.0; //3-4.5 W3C recommends a minimum ratio of 3:1
        return contrast > 1.6
    }
    
}
