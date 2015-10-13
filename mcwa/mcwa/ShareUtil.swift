//
//  ShareUtils.swift
//  mcwa
//
//  Created by 陈强 on 15/10/13.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import Foundation
import UIKit

let shareToNames : [AnyObject] = [UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]
class ShareUtil {
    
    class func shareInitWithTextAndPicture(controller: UIViewController,text:String,image:UIImage,shareUrl:String,callDelegate:UMSocialUIDelegate) {
        
        UMSocialConfig.setFinishToastIsHidden(true, position: UMSocialiToastPositionTop)
        
        UMSocialData.defaultData().extConfig.qzoneData.title = "mc哇"
        UMSocialData.defaultData().extConfig.qqData.title = "mc哇"
        UMSocialData.defaultData().extConfig.wechatSessionData.title = "mc哇"
        UMSocialData.defaultData().extConfig.wechatTimelineData.title = "mc哇"
        
        UMSocialData.defaultData().extConfig.qzoneData.url = shareUrl;
        UMSocialData.defaultData().extConfig.qqData.url = shareUrl;
        UMSocialData.defaultData().extConfig.wechatSessionData.url = shareUrl;
        UMSocialData.defaultData().extConfig.wechatTimelineData.url = shareUrl;
        UMSocialSnsService.presentSnsIconSheetView(controller, appKey: UMAppKey, shareText: text, shareImage: image, shareToSnsNames: shareToNames, delegate:callDelegate)
    }
    
    
}