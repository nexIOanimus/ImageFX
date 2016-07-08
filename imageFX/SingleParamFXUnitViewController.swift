//
//  SingleParamFXUnitViewController.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/13/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit

class SingleParamFXUnitViewController: FXUnitViewController {
    
    @IBOutlet weak var imageView: UIImageView?
    var image: UIImage!
    var originalImage: UIImage!
    
    var fxUnit : SingleParamFXUnit?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView?.contentMode = UIViewContentMode.ScaleAspectFit;
        self.imageView!.image = self.image
        
        self.originalImage = self.image
        
        fxUnit?.setImageOriginal(image)
        
        fxUnit?.setImage = setImageVar
        fxUnit?.setProxy = setImageProxy
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func setImageVar(image: UIImage) {
        self.image = image
        self.imageView?.image = image
    }
    
    override func setImageProxy(image: UIImage) {
        self.imageView?.image = image
    }
    
    @IBAction func updateImage(sender: UISlider) {
        fxUnit?.computeFX(sender.value)
    }

    @IBAction func applyChanges(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.setMainImage(image)
        exitFX(sender)
    }
    
    @IBAction func exitFX(sender: AnyObject) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.currentFX = nil
        dismissViewControllerAnimated(true, completion: nil)
    }

}
