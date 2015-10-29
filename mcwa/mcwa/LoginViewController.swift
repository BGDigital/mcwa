//
//  LoginViewController.swift
//  mcwa
//
//  Created by 陈强 on 15/10/21.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController,UMSocialUIDelegate {
    @IBOutlet weak var loginBtn: UIButton!
    
    var Delegate: LoginDelegate?
    var manager = AFHTTPRequestOperationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "登录"
        self.view.layer.contents = UIImage(named: "login_bg")!.CGImage
        // Do any additional setup after loading the view.
        if(!WXApi.isWXAppInstalled()){
            self.loginBtn.hidden = true
            self.navigationItem.title = ""
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginAction(sender: UIButton) {
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToWechatSession)
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{(response:UMSocialResponseEntity!) ->Void in
            if(response.responseCode == UMSResponseCodeSuccess){
                UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToWechatSession, completion: {(res:UMSocialResponseEntity!) ->Void in
                    var data = res.data
                    let openId:String = data["openid"] as! String!
                    let nickName:String = data["screen_name"] as! String!
                    let headImg:String = data["profile_image_url"] as! String!
                    let accessToken:String = data["access_token"] as! String!
                    let genderInt:Int = data["gender"] as! Int
                    let gender:String = genderInt==1 ? "男":"女"
                    let params = [
                        "accessToken": accessToken,
                        "openId": openId,
                        "nickName": nickName,
                        "gender": gender,
                        "headImg": headImg,
                    ]
                    
                    self.manager.POST(qqlogin_url,
                        parameters: params,
                        success: { (operation: AFHTTPRequestOperation!,
                            responseObject: AnyObject!) in
                            if (responseObject != nil)  {
                                var json = JSON(responseObject)
                                if "ok" == json["state"].stringValue {
                                    
                                    MCUtils.AnalysisUserInfo(json["dataObject"])
                                    self.navigationController?.popViewControllerAnimated(true)
                                    MCUtils.showCustomHUD("登录成功", aType: .Success)
                                    self.Delegate?.loginSuccessfull!()
                                }else{
                                    MCUtils.showCustomHUD("登录失败,请稍候再试", aType: .Error)
                                }
                            } else {
                                MCUtils.showCustomHUD("登录失败,请稍候再试", aType: .Error)
                            }
                            
                        },
                        failure: { (operation: AFHTTPRequestOperation!,
                            error: NSError!) in
                            MCUtils.showCustomHUD("登录失败,请稍候再试", aType: .Error)
                    })

                    
                })
                
            }
        })

    }
    
    class func showLoginViewPage(fromNavigation:UINavigationController?, delegate: LoginDelegate?){
        let loginView = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("loginViewController") as! LoginViewController
        loginView.Delegate = delegate
        if (fromNavigation != nil) {
            fromNavigation?.pushViewController(loginView, animated: true)
        } else {
            fromNavigation?.presentViewController(loginView, animated: true, completion: nil)
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        MobClick.beginLogPageView("LoginViewController")
    }
    override func viewWillDisappear(animated: Bool) {
        MobClick.endLogPageView("LoginViewController")
        
    }
    
}