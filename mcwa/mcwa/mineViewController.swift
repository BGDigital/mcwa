//
//  mineViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/21.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class mineViewController: UIViewController {

    @IBOutlet weak var iv_userAvatar: UIImageView!
    @IBOutlet weak var lb_nickName: UILabel!
    @IBOutlet weak var lb_answerCount: UILabel!
    @IBOutlet weak var lb_QuestionCount: UILabel!
    @IBOutlet weak var lb_totalSource: UILabel!
    @IBOutlet weak var lb_avgSource: UILabel!
    @IBOutlet weak var v_line_1: UIView!
    @IBOutlet weak var v_line_2: UIView!
    @IBOutlet weak var v_line_3: UIView!
    @IBOutlet weak var v_line_4: UIView!
    
    var manager = AFHTTPRequestOperationManager()
    var json: JSON! {
        didSet {
            if "ok" == self.json["state"].stringValue {
                let avatar_Url = self.json["dataObject", "headImg"].stringValue
                iv_userAvatar.sd_setImageWithURL(NSURL(string: avatar_Url))
                lb_nickName.text = self.json["dataObject", "nickName"].stringValue
                lb_answerCount.text = self.json["dataObject", "answerNum"].stringValue
                lb_QuestionCount.text = self.json["dataObject", "uploadNum"].stringValue
                lb_totalSource.text = self.json["dataObject", "allScore"].stringValue
                lb_avgSource.text = "0"//self.json["dataObject", "nickName"].stringValue
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iv_userAvatar.layer.masksToBounds = true
        self.iv_userAvatar.layer.cornerRadius = self.iv_userAvatar.bounds.height / 2
        self.iv_userAvatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.iv_userAvatar.layer.borderWidth = 2
        v_line_1.backgroundColor = UIColor(hexString: "#3B2C56")
        v_line_2.backgroundColor = UIColor(hexString: "#3B2C56")
        v_line_3.backgroundColor = UIColor(hexString: "#3B2C56")
        v_line_4.backgroundColor = UIColor(hexString: "#3B2C56")
        loadNewData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewData() {
        //开始刷新
        //http://221.237.152.39:8081/interface.do?act=userInfo&userId=2
        let dict = ["act":"userInfo", "userId": 2]
        manager.GET(URL_MC,
            parameters: dict,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.json = JSON(responseObject)
                //                self.hud?.hide(true)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                MCUtils.showCustomHUD("数据加载失败", aType: .Error)
        })
    }

    class func showMineInfoPage(fromNavigation:UINavigationController?){
        let mine = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mineViewController") as! mineViewController
        if (fromNavigation != nil) {
            fromNavigation?.pushViewController(mine, animated: true)
        } else {
            fromNavigation?.presentViewController(mine, animated: true, completion: nil)
        }
        
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
