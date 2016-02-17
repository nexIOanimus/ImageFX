//
//  ViewController.swift
//  imageFX
//
//  Created by Serge-Olivier Amega on 2/9/16.
//  Copyright © 2016 Nexiosoft. All rights reserved.
//

import UIKit
import MobileCoreServices


/**
 Invariants:
 
 currentImage must always not be nil
*/
class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var currentImage: UIImage = UIImage()
    
    func setImage(newImage: UIImage) {
        self.currentImage = newImage
        imageView.image = self.currentImage
    }

    @IBAction func importPhoto(sender: AnyObject) {
        
        let srcType = UIImagePickerControllerSourceType.PhotoLibrary
        let imgType = String(kUTTypeImage)
        
        guard (UIImagePickerController.isSourceTypeAvailable(srcType) &&
            UIImagePickerController.availableMediaTypesForSourceType(srcType)!.contains(imgType)) else {
                print("Cannot Import Photos")
                return
        }
        
        let vc = UIImagePickerController()
        vc.mediaTypes = [imgType]
        vc.delegate = self
        presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func showFXView(sender: AnyObject) {
        let vc = FXChooserTableViewController()
        showViewController(vc, sender: sender)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        setImage(image)
        //imageView.sizeToFit()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = UIViewContentMode.ScaleAspectFit;
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        guard let fxUnit = appDelegate.currentFX else {
            print("no FX")
            return
        }
        
        guard let vc = fxUnit.makeViewController() else {
            print("no ViewController for fxUnit")
            return
        }
        
        vc.setImageVar(currentImage)
        presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

