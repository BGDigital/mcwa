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
    var sourceResult: Array<JSON>?
    
    
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
        iv_center_avatar.layer.borderWidth = 1.5
        iv_center_avatar.layer.borderColor = UIColor(hexString: "#321D50")!.CGColor
        
        v_center.layer.borderWidth = 0.5
        v_center.layer.borderColor = UIColor(hexString: "#645093")!.CGColor
        
        
        showSourceInfo()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*		{
    "allScore": 6200,
    "answerNum": 0,
    "headImg": "http://qzapp.qlogo.cn/qzapp/1104907496/1AAFEA85B6D61B6DBBA78DE45A28AF56/100",
    "id": 2,
    "nickName": "|  ｀妖孽先生  ",
    "scoreRank": 1,
    "uploadNum": 0
    },
*/
    func showSourceInfo() {
        if let top = self.sourceResult?[0] {
            if top.isEmpty {
                v_top.hidden = true
            } else {
                v_top.hidden = false
                lb_top_no.text = top["scoreRank"].stringValue
                iv_top_avatar.sd_setImageWithURL(NSURL(string: top["headImg"].stringValue))
                iv_top_avatar.layer.masksToBounds = true
                iv_top_avatar.layer.cornerRadius = 20
                lb_top_source.text = top["allScore"].stringValue
            }
        }
        if let me = sourceResult?[1] {
            if me.isEmpty {
                v_center.hidden = true
            } else {
                v_center.hidden = false
                lb_center_no.text = me["scoreRank"].stringValue
                iv_center_avatar.sd_setImageWithURL(NSURL(string: me["headImg"].stringValue))
                iv_center_avatar.layer.masksToBounds = true
                iv_center_avatar.layer.cornerRadius = 37.5//iv_center_avatar.bounds.size.height / 2
                lb_center_source.text = me["allScore"].stringValue
            }
        }
        if let bottom = sourceResult?[2] {
            if bottom.isEmpty {
                v_bottom.hidden = true
            } else {
                v_bottom.hidden = false
                lb_bottom_no.text = bottom["scoreRank"].stringValue
                iv_bottom_avater.sd_setImageWithURL(NSURL(string: bottom["headImg"].stringValue))
                iv_bottom_avater.layer.masksToBounds = true
                iv_bottom_avater.layer.cornerRadius = 20
                lb_bottom_source.text = bottom["allScore"].stringValue
            }

        }
        
    }
    
    //这里想返回到主界面
    @IBAction func backToMain(sender: UIButton) {
        //let main = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mainViewController") as! ViewController
        self.dismissViewControllerAnimated(true, completion: nil)
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
