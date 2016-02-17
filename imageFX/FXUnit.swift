//
//  FXUnit.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/10/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit
import ImageIO

class FXUnit: NSObject {
    
    let name: String
    var original: UIImage?
    var originalProxy: UIImage?
    
    init(name: String) {
        self.name = name
    }
    
    func setImageOriginal(image: UIImage) {
        original = image
        
        let smallSize : CGSize = CGSizeApplyAffineTransform(image.size, CGAffineTransformMakeScale(0.3, 0.3))
        
        UIGraphicsBeginImageContextWithOptions(smallSize, false, 0.0)
        
        image.drawInRect(CGRectMake(0, 0, smallSize.width, smallSize.height))
        originalProxy = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
    }
    
    class func getFXListForGroupName(groupName :String) -> [FXUnit] {
        
        switch groupName {
        case FXGroup.FXGroupBasicName :
            return basicFXList()
        case FXGroup.FXGroupBlurName:
            return blurFXList()
        default:
            return []
        }
        
    }
    
    func makeViewController() -> FXUnitViewController? {
        print("default makeViewController called")
        return nil
    }
}

private func basicFXList() -> [FXUnit] {
    return [BrightnessFXUnit(), ContrastFXUnit(), SaturationFXUnit(), HighlightsFXUnit(), ShadowsFXUnit(), WhiteLevelFXUnit(), BlackLevelFXUnit()]
}

private func blurFXList() -> [FXUnit] {
    return [BlurFXUnit()]
}