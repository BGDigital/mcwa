//
//  McUtils.swift
//  mcwa
//
//  Created by 陈强 on 15/10/13.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import Foundation

let UMAppKey = "561bcfe1e0f55a0219005cab"
let qq_AppId = "1104907496"
let qq_AppKey = "DbdC0Qvfkj4yOLsG"
let wx_AppId = "wx49ba2c7147d2368d"
let wx_AppKey = "85aa75ddb9b37d47698f24417a373134"
let share_url = "http://www.mckuai.com"

//用户ID
let D_USER_ID = "UserLoginId"
//用户昵称
let D_USER_NICKNAME = "UserNickName"

//保存的用户ID
var appUserIdSave: Int = 0
var appUserNickName: String = ""


let URL_MC = "http://192.168.10.106/interface.do?"
//上传头像/图片
let upload_url = URL_MC+"act=uploadImg"
let addTalk_url = URL_MC+"act=uploadQuestion"
let qqlogin_url = URL_MC+"act=login"

class MCUtils {

    /**
    显示HUD提示框
    
    :param: view    要显示HUD的窗口
    :param: title   HUD的标题
    :param: imgName 自定义HUD显示的图片
    */
    class func showCustomHUD(aMsg: String, aType: TSMessageNotificationType) {
        switch aType {
        case .Success:
            TSMessage.showNotificationWithTitle("操作成功", subtitle: aMsg, type: aType)
        case .Warning:
            TSMessage.showNotificationWithTitle("MC哇提示", subtitle: aMsg, type: aType)
        case .Error:
            TSMessage.showNotificationWithTitle("出错啦~!", subtitle: aMsg, type: aType)
        default:
            TSMessage.showNotificationWithTitle("消息", subtitle: aMsg, type: aType)
        }
        
    }
    
    
    /**
    保存用户配置信息
    
    :param: j JSON
    */
    class func AnalysisUserInfo(j: JSON) {
        let userId = j["id"].intValue
        let nickName = j["nickName"].stringValue
        //保存登录信息
        Defaults[D_USER_ID] = userId
        Defaults[D_USER_NICKNAME] = nickName

        
        appUserIdSave = userId
        appUserNickName = nickName

    }
    

}



