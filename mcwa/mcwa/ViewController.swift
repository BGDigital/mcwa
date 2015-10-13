//
//  ViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/8.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.navigationItem.title = "MC哇!"
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //主界面背景渐变
        let background = turquoiseColor()
        background.frame = self.view.bounds
        self.view.layer.insertSublayer(background, atIndex: 0)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "MC哇!"
    }
    
    //颜色渐变
    func turquoiseColor() -> CAGradientLayer {
        
        let topColor = UIColor(hexString: "#362057")
        
        let bottomColor = UIColor(hexString: "#3b3f73")
        
        let gradientColors: Array <AnyObject> = [topColor!.CGColor, bottomColor!.CGColor]
        
        let gradientLocations: Array <NSNumber> = [0.0, 1.0]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.locations = gradientLocations
        
        return gradientLayer
        
    }



}

