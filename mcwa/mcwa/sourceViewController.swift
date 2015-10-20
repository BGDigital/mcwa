//
//  sourceViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/20.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class sourceViewController: UIViewController {

    @IBOutlet weak var v_top: UIView!
    @IBOutlet weak var lb_top_no: UILabel!
    @IBOutlet weak var iv_top_avatar: UIImageView!
    @IBOutlet weak var lb_top_source: UILabel!
    
    @IBOutlet weak var iv_center_avatar: UIImageView!
    @IBOutlet weak var lb_center_source: UILabel!
    
    @IBOutlet weak var v_bottom: UIView!
    @IBOutlet weak var lb_bottom_no: UILabel!
    @IBOutlet weak var iv_bottom_avater: UIImageView!
    @IBOutlet weak var lb_bottom_source: UILabel!
    
    @IBOutlet weak var btn_doAgain: UIButton!
    @IBOutlet weak var btn_share: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.layer.contents = UIImage(named: "main_bg")!.CGImage
        v_top.layer.contents = UIImage(named: "source_top")!.CGImage
        v_bottom.layer.contents = UIImage(named: "source_bottom")!.CGImage
        
        iv_center_avatar.layer.masksToBounds = true
        iv_center_avatar.layer.cornerRadius = 37.5
        iv_center_avatar.layer.borderWidth = 1
        iv_center_avatar.layer.borderColor = UIColor(hexString: "#30174F")!.CGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
