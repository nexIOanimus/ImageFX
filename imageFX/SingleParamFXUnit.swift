//
//  SingleParamFXUnit.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/16/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

class SingleParamFXUnit: FXUnit {
    var fxFilter : CIFilter
    var key: String!
    var multiplier: Float! = 1.0
    var offset: Float! = 0
    var setImage: (UIImage) -> Void
    var setProxy: (UIImage) -> Void
    
    let context = CIContext(options: nil)
    
    override init(name: String) {
        fxFilter = CIFilter()
        setProxy = {(UIImage)->Void in}
        setImage = {(UIImage)->Void in}
        super.init(name: name)
    }
    
    func computeFX(param: Float) {
        ProxyScheduler.getInstance().runTask(proxy: {
            self.computeProxy(param)
        }, actual: {
            self.computeFull(param)
        })
    }
    
    func compute(param: Float, image: UIImage, onFinish: (UIImage) -> Void) {
        guard let originalImage = CIImage(image: image) else {
            return
        }
        
        fxFilter.setValue(originalImage, forKey: kCIInputImageKey)
        fxFilter.setValue(param * multiplier + offset, forKey: key)
        
        if let out = self.fxFilter.outputImage {
            dispatch_async(dispatch_get_main_queue(), {
                let renderedImage = self.context.createCGImage(out, fromRect: out.extent)
                onFinish(UIImage(CGImage: renderedImage))
            })
        }
    }
    
    func computeFull(param: Float) {
        compute(param, image: self.original!, onFinish: self.setImage)
    }
    
    func computeProxy(param: Float) {
        compute(param, image: self.originalProxy!, onFinish: self.setProxy)
    }
    
    override func makeViewController() -> FXUnitViewController {
        let vc = SingleParamFXUnitViewController()
        vc.fxUnit = self
        return vc
    }
}

class BrightnessFXUnit: SingleParamFXUnit {
    
    init() {
        super.init(name: "brightness")
        key = "inputBrightness"
        multiplier = 0.3
        self.fxFilter = CIFilter(name: "CIColorControls")!
    }
}

class ContrastFXUnit: SingleParamFXUnit {
    
    init() {
        super.init(name: "contrast")
        key = "inputContrast"
        multiplier = 0.1
        offset = 1
        self.fxFilter = CIFilter(name: "CIColorControls")!
    }
}

class SaturationFXUnit: SingleParamFXUnit {
    
    init() {
        super.init(name: "saturation")
        key = "inputSaturation"
        offset = 1
        self.fxFilter = CIFilter(name: "CIColorControls")!
    }
}

class HighlightsFXUnit: SingleParamFXUnit {
    
    init() {
        super.init(name: "highlights")
        key = "inputHighlightAmount"
        offset = 1
        self.fxFilter = CIFilter(name: "CIHighlightShadowAdjust")!
    }
}

class ShadowsFXUnit: SingleParamFXUnit {
    
    init() {
        super.init(name: "shadows")
        key = "inputShadowAmount"
        self.fxFilter = CIFilter(name: "CIHighlightShadowAdjust")!
    }
}

class ExposureFXUnit : SingleParamFXUnit {
    //inputEV * .5 + .5
    init() {
        super.init(name: "exposure")
        key = "inputEV"
        multiplier = 0.5
        offset = 0.5
        self.fxFilter = CIFilter(name: "CIExposureAdjust")!
    }
}

class WhiteLevelFXUnit: SingleParamFXUnit {
    init() {
        super.init(name: "white level")
        self.fxFilter = CIFilter(name: "CIToneCurve")!
    }
    
    override func compute(param: Float, image: UIImage, onFinish: (UIImage) -> Void) {
        guard let originalImage = CIImage(image: image) else {
            return
        }
        
        let vecValue : CGFloat = CGFloat(param * 0.5 + 1)
        let inVec = CIVector(x: 1, y: vecValue)
        
        fxFilter.setValue(originalImage, forKey: kCIInputImageKey)
        fxFilter.setValue(inVec, forKey: "inputPoint4")
        
        if let out = fxFilter.outputImage {
            let renderedImage = context.createCGImage(out, fromRect: out.extent)
            onFinish(UIImage(CGImage: renderedImage))
        }
    }
}

class BlackLevelFXUnit: SingleParamFXUnit {
    init() {
        super.init(name: "black level")
        self.fxFilter = CIFilter(name: "CIToneCurve")!
    }
    
    override func compute(param: Float, image: UIImage, onFinish: (UIImage) -> Void) {
        guard let originalImage = CIImage(image: image) else {
            return
        }
        
        let vecValue : CGFloat = CGFloat(param * 0.5)
        let inVec = CIVector(x: 0, y: vecValue)
        
        fxFilter.setValue(originalImage, forKey: kCIInputImageKey)
        fxFilter.setValue(inVec, forKey: "inputPoint0")
        
        if let out = fxFilter.outputImage {
            let renderedImage = context.createCGImage(out, fromRect: out.extent)
            onFinish(UIImage(CGImage: renderedImage))
        }
    }
}

//TODO make preserveTransparencyGaussianBlur
class BlurFXUnit : SingleParamFXUnit {
    //inputRadius * 10 + 10
    init() {
        super.init(name: "blur")
        key = "inputRadius"
        multiplier = 10
        offset = 10
        self.fxFilter = CIFilter(name: "CIGaussianBlur")!
    }
}
