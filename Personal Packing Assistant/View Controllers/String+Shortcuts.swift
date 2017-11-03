//
//  String+Shortcuts.swift
//  Personal Packing Assistant
//
//  Created by Raj Iyer on 11/2/17.
//  Copyright © 2017 CS407. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func image() -> UIImage {
        let size = CGSize(width: 60, height: 60)
        let PointZero = CGPoint(x: 0,y :0)
        UIGraphicsBeginImageContextWithOptions(size, false, 0);
        UIColor.clear.set()
        let rect = CGRect(origin: PointZero, size: size)
        UIRectFill(CGRect(origin: PointZero, size: size))
        (self as NSString).draw(in: rect, withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 50)])
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}
