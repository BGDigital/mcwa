//
//  share.swift
//  mcwa
//
//  Created by 陈强 on 15/10/12.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import Foundation
import UIKit

class share: UIViewController,UMSocialUIDelegate,UMSocialDataDelegate {
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var shareBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginAction(sender: UIButton) {
        print("login")
        let snsPlatform:UMSocialSnsPlatform = UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToQQ)
        snsPlatform.loginClickHandler(self,UMSocialControllerService.defaultControllerService(),true,{(response:UMSocialResponseEntity!) ->Void in
            if(response.responseCode == UMSResponseCodeSuccess){
                UMSocialDataService.defaultDataService().requestSnsInformation(UMShareToQQ, completion: {(res:UMSocialResponseEntity!) ->Void in
                    var data = res.data
//                    var snsAccount = UMSocialAccountManager.socialAccountDictionary()
//                    var qqUser:UMSocialAccountEntity = snsAccount[UMShareToQQ] as! UMSocialAccountEntity
                    var openId:String = data["openid"] as! String!
                    var nickName:String = data["screen_name"] as! String!
                    var headImg:String = data["profile_image_url"] as! String!
                    var accessToken:String = data["access_token"] as! String!
                    var gender:String = data["gender"] as! String!
                })

            }
        })

        
    }
    
    func didFinishGetUMSocialDataResponse(response: UMSocialResponseEntity!) {
        print(response.data)
    }

    @IBAction func shareAction(sender: UIButton) {
        print("share")
        let shareImg: UIImage! = UIImage(named: "share_default")
        let shareText:String! = "jdskfjlskdjflkdsjflkdjf"
        
        ShareUtil.shareInitWithTextAndPicture(self, text: shareText, image: shareImg!,shareUrl:"http://www.baidu.com", callDelegate: self)
    }
    
    func didFinishGetUMSocialDataInViewController(response: UMSocialResponseEntity!) {
        if(response.responseCode == UMSResponseCodeSuccess) {
            
        }
    }
}