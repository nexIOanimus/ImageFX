//
//  ProxyScheduler.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/17/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

private let blockingQueue = dispatch_queue_create("com.nexiosoft.imageFXBlock.sync", DISPATCH_QUEUE_SERIAL)
private let processingQueue = dispatch_queue_create("com.nexiosoft.imageFXProcess.sync", DISPATCH_QUEUE_SERIAL)

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
        dispatch_async(blockingQueue) {
            if self.functions.count > 1 {
                self.functions.removeRange(1..<self.functions.count)
            }
            
            self.functions.append(proxy)
            self.functions.append(actual)
            
            /*
             if (!isRunning) {
             self.isRunning = true
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
             while !self.functions.isEmpty {
             if let f : (()->Void) = self.functions.removeFirst() {
             f()
             }
             }
             self.isRunning = false
             })
             }
             */
            
            func runFunctions() {
                dispatch_async(blockingQueue) {
                    if let f : (()->Void) = self.functions.removeFirst() {
                        dispatch_async(processingQueue) {
                            f();
                        }
                    }
                    
                    if !self.functions.isEmpty {
                        runFunctions();
                    } else {
                        self.isRunning = false;
                    }
                }
            }
            
            if !self.isRunning {
                self.isRunning = true;
                runFunctions();
            }
        }
    }
}
