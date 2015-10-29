//
//  mineViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/21.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class mineViewController: UIViewController,UMSocialUIDelegate, LoginDelegate, UIAlertViewDelegate {

    @IBOutlet weak var btn_LoginOrShare: UIButton!
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
    @IBOutlet weak var btn_music: UIBarButtonItem!
    @IBOutlet weak var btn_loginout: UIBarButtonItem!
    
    
    var scoreRank:Int = 0
    var manager = AFHTTPRequestOperationManager()
    var json: JSON! {
        didSet {
            if "ok" == self.json["state"].stringValue {
                scoreRank = self.json["dataObject","scoreRank"].intValue
                let avatar_Url = self.json["dataObject", "headImg"].stringValue
                iv_userAvatar.sd_setImageWithURL(NSURL(string: avatar_Url))
                lb_nickName.text = self.json["dataObject", "nickName"].stringValue
                lb_answerCount.text = self.json["dataObject", "answerNum"].stringValue
                lb_QuestionCount.text = self.json["dataObject", "uploadNum"].stringValue
                lb_totalSource.text = self.json["dataObject", "allScore"].stringValue
                if self.json["dataObject", "answerNum"].intValue == 0 {
                    lb_avgSource.text = self.json["dataObject", "allScore"].stringValue
                } else {
                    let avgSource = (self.json["dataObject", "allScore"].intValue / self.json["dataObject", "answerNum"].intValue)
                    lb_avgSource.text = String(avgSource)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.iv_userAvatar.layer.masksToBounds = true
        self.iv_userAvatar.layer.cornerRadius = (self.view.bounds.size.width * 0.333) / 2
        self.iv_userAvatar.layer.borderColor = UIColor.whiteColor().CGColor
        self.iv_userAvatar.layer.borderWidth = 2
        v_line_1.backgroundColor = UIColor(hexString: "#3B2C56")
        v_line_2.backgroundColor = UIColor(hexString: "#3B2C56")
        v_line_3.backgroundColor = UIColor(hexString: "#3B2C56")
        v_line_4.backgroundColor = UIColor(hexString: "#3B2C56")
        if appUserLogined {
            btn_LoginOrShare.tag = 1
            btn_LoginOrShare.setTitle("炫耀一下", forState: .Normal)
            loadNewData()
            btn_LoginOrShare.addTarget(self, action: "shareTo:", forControlEvents: UIControlEvents.TouchUpInside)
        } else {
            btn_LoginOrShare.tag = 0
            btn_LoginOrShare.setTitle("点我登录", forState: .Normal)
            btn_LoginOrShare.addTarget(self, action: "showLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        if appMusicStatus == 1 {
            btn_music.image = UIImage(assetIdentifier: .Music_On)
        } else {
            btn_music.image = UIImage(assetIdentifier: .Music_Off)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadNewData() {
        //开始刷新
        //http://221.237.152.39:8081/interface.do?act=userInfo&userId=2
        let dict = ["act":"userInfo", "userId": appUserIdSave]
        manager.GET(URL_MC,
            parameters: dict,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                self.json = JSON(responseObject)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                MCUtils.showCustomHUD("数据加载失败", aType: .Error)
        })
    }
    
    //开关背景音乐,改变状态
    @IBAction func TurnOnOff(sender: UIBarButtonItem) {
        print("appMusicStatus\(appMusicStatus)")
        if let p = player_bg.player {
            if appMusicStatus == 1 {
                //打开状态,点击关闭
                appMusicStatus = 0
                Defaults[.MusicStatus] = 0
                sender.image = UIImage(assetIdentifier: .Music_Off)
                p.pause()
            } else {
                //关闭状态,点击打开
                appMusicStatus = 1
                Defaults[.MusicStatus] = 1
                sender.image = UIImage(assetIdentifier: .Music_On)
                p.play()
            }
        } else {
            //关闭状态,点击打开
            appMusicStatus = 1
            Defaults[.MusicStatus] = 1
            sender.image = UIImage(assetIdentifier: .Music_On)
            player_bg.playFileAtPath(music_bg)
        }
    }
    

    class func showMineInfoPage(fromNavigation:UINavigationController?){
        let mine = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("mineViewController") as! mineViewController
        if (fromNavigation != nil) {
            fromNavigation?.pushViewController(mine, animated: true)
        } else {
            fromNavigation?.presentViewController(mine, animated: true, completion: nil)
        }
        
    }

    @IBAction func shareTo(sender: UIButton) {
        if sender.tag == 1 {
            let rect:CGRect = self.view.frame
            UIGraphicsBeginImageContext(rect.size)
            let context:CGContextRef = UIGraphicsGetCurrentContext()!
            view.layer.renderInContext(context)
            let shareImg: UIImage! = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            ShareUtil.shareInitWithTextAndPicture(self, text: "我正在玩mc哇,这里有来自世界各地我的世界minecraft玩家,我已经是第"+String(scoreRank)+"名了,谁敢来挑战我,敢show出你的排名吗?",image:shareImg,shareUrl:share_url,callDelegate:self)
        }
    }
    
    @IBAction func showLogin(sender: UIButton) {
        if sender.tag == 0 {
            LoginViewController.showLoginViewPage(self.navigationController, delegate: self)
        }
    }
    
    //登录成功,刷新界面
    func loginSuccessfull() {
        btn_LoginOrShare.tag = 1
        btn_LoginOrShare.setTitle("炫耀一下", forState: .Normal)
        loadNewData()
        btn_LoginOrShare.addTarget(self, action: "shareTo:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if(response.responseCode == UMSResponseCodeSuccess) {
            
        }
    }
    
    @IBAction func onLoginout(sender: UIBarButtonItem) {
        if appUserLogined {
            UIAlertView(title: "提示", message: "注销后将不能参与排名,确定要注销吗?", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定").show()
        } else {
            UIAlertView(title: "提示", message: "亲,你还没有登录哦", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "登录").show()
        }
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if appUserLogined {
            if buttonIndex != alertView.cancelButtonIndex {
                //注销登录
                appUserIdSave = 0
                appUserAvatar = ""
                appUserNickName = ""
                appUserLogined = false
                
                Defaults[DefaultsKeys.UserId] = 0
                Defaults[DefaultsKeys.NickName] = ""
                Defaults[DefaultsKeys.UserAvater] = ""
                Defaults[DefaultsKeys.logined] = false
                
                self.navigationController?.popViewControllerAnimated(true)
            }
        } else {
            if buttonIndex != alertView.cancelButtonIndex {
                LoginViewController.showLoginViewPage(self.navigationController, delegate: self)
            }
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
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("mineViewController")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("mineViewController")
        
    }

}
