//
//  FXGroups.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/10/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

class FXGroup: NSObject {
    static let FXGroupBasicName : String = "Basic"
    static let FXGroupCoolName : String = "Cool"
    static let FXGroupBlurName : String = "Blur"
    
    let name : String
    
    init(name: String) {
        self.name = name
    }
    
    class func getFXGroups() -> [FXGroup] {
        return [FXGroup(name: FXGroupBasicName), FXGroup(name: FXGroupCoolName), FXGroup(name: FXGroupBlurName)]
    }
}
