//
//  ProxyScheduler.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/17/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

class ProxyScheduler: NSObject {
    
    var functions : [()->Void]
    var isRunning : Bool
    
    static var instance: ProxyScheduler? = nil
    
    class func getInstance() -> ProxyScheduler {
        if instance == nil {
            instance = ProxyScheduler()
        }
        return instance!
    }
    
    override init() {
        functions = []
        isRunning = false
        super.init()
    }
    
    func runTask(proxy proxy: ()->Void, actual: ()->Void) {
        
        if functions.count > 1 {
            functions.removeRange(1..<functions.count)
        }
        functions.append(proxy)
        functions.append(actual)
        
        if (!isRunning) {
            dispatch_async(dispatch_get_main_queue(), {
                self.isRunning = true
                while !self.functions.isEmpty {
                    let f = self.functions.removeFirst()
                    f()
                }
                self.isRunning = false
            })
        }
    }
}
