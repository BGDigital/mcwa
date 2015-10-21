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
    
    @IBOutlet weak var v_center: UIView!
    @IBOutlet weak var lb_center_no: UILabel!
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
        self.navigationItem.title = "成绩"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()

        //self.view.layer.contents = UIImage(named: "main_bg")!.CGImage
        v_top.layer.contents = UIImage(named: "source_top")!.CGImage
        v_bottom.layer.contents = UIImage(named: "source_bottom")!.CGImage
        
        iv_center_avatar.layer.masksToBounds = true
        iv_center_avatar.layer.cornerRadius = 37.5
        iv_center_avatar.layer.borderWidth = 0.5
        iv_center_avatar.layer.borderColor = UIColor(hexString: "#30174F")!.CGColor
        
        v_center.layer.borderWidth = 0.5
        v_center.layer.borderColor = UIColor(hexString: "#645093")!.CGColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //这里想返回到主界面
    @IBAction func backToMain(sender: UIButton) {
//        let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainViewController") as! ViewController
        //self.dismissViewControllerAnimated(true, completion: nil)
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
