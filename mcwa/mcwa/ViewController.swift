//
//  ViewController.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/8.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, PlayerDelegate {

    @IBOutlet weak var userAvatar: UIBarButtonItem!
    let manager = AFHTTPRequestOperationManager()
    var json: JSON! {
        didSet {
            if "ok" == self.json["state"].stringValue {
                if let d = self.json["dataObject", "question"].array {
                    self.questions = d
                }
                if let users = self.json["dataObject", "user"].array {
                    self.users = users
                }
            }
        }
    }
    var questions: Array<JSON>?
    var users: Array<JSON>?
    var buttonBack: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MCUtils.checkNetWorkState(self)
        //背景音乐
        player_bg.delegate = self
        player_bg.forever = true
        print("appMusicStatus:\(appMusicStatus)")
        if (appMusicStatus == 0) {
            player_bg.playFileAtPath(music_bg)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //主界面背景渐变
//        let background = turquoiseColor()
//        background.frame = self.view.bounds
//        self.view.layer.insertSublayer(background, atIndex: 0)
        //方法一
        self.view.layer.contents = UIImage(named: "main_bg")!.CGImage
        //方法二 说的是占内存
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "main_bg")!)
        custom_leftbar()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
    }
    
    func soundFinished(sender: AnyObject) { // delegate message from Player
        print("play finished")
    }

    
    func custom_leftbar() {
        buttonBack = UIButton(type: UIButtonType.Custom)
        buttonBack.frame = CGRectMake(5, 0, 30, 30)
        if let url = appUserAvatar {
            buttonBack.yy_setImageWithURL(NSURL(string: url), forState: .Normal, placeholder: UIImage(named: "avatar_default"))
        } else {
            buttonBack.setImage(UIImage(named: "avatar_default"), forState: .Normal)
        }
        buttonBack.addTarget(self, action: "showLogin:", forControlEvents: UIControlEvents.TouchUpInside)
        buttonBack.layer.masksToBounds = true
        buttonBack.layer.cornerRadius = 15
        buttonBack.layer.borderWidth = 1.5
        buttonBack.layer.borderColor = UIColor(hexString: "#675580")?.CGColor
        let leftBarButtonItem: UIBarButtonItem = UIBarButtonItem(customView: buttonBack)
        self.navigationItem.setLeftBarButtonItem(leftBarButtonItem, animated: true)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func beginWa(sender: UIButton) {
        self.pleaseWait()
        
        let dict = ["act":"question"]
        manager.GET(URL_MC,
            parameters: dict,
            success: {
                (operation, responseObject) -> Void in
                self.json = JSON(responseObject)
                self.clearAllNotice()
                //收到数据,跳转到准备页面
                self.performSegueWithIdentifier("showReady", sender: self)
            }) { (operation, error) -> Void in
                self.clearAllNotice()
                MCUtils.showCustomHUD(self, aMsg: "获取题库失败,请重试", aType: .Error)
                print(error)
        }
    }
    
    //跳转Segue传值
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {        
        if segue.identifier == "showReady" {
            let receive = segue.destinationViewController as! readyViewController
            receive.questions = self.questions
            receive.users = self.users
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.title = "MC哇!"
        MobClick.beginLogPageView("viewController")
        self.navigationController?.navigationBarHidden = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("viewController")
    }
    
    override func viewDidAppear(animated: Bool) {
        if let url = appUserAvatar {
            buttonBack.yy_setImageWithURL(NSURL(string: url), forState: .Normal, placeholder: UIImage(named: "avatar_default"))
        } else {
            buttonBack.setImage(UIImage(named: "avatar_default"), forState: .Normal)
        }
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
    
    
    @IBAction func showLogin(sender: UIBarButtonItem) {
        mineViewController.showMineInfoPage(self.navigationController)
    }


}

