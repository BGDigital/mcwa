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
let wx_AppId = "wxc49b6a0e3c78364d"
let wx_AppKey = "d4624c36b6795d1d99dcf0547af5443d"
let share_url = "http://wa.mckuai.com/down"

//用户登录,注销Delegate
@objc protocol LoginDelegate {
//    var isLogined: Int? {get set}
    optional func loginSuccessfull()
    optional func loginout()
}


extension DefaultsKeys {
    static let logined = DefaultsKey<Bool>("UserLogined")
    static let UserAvater = DefaultsKey<String?>("UserAvatar")
    static let NickName = DefaultsKey<String?>("UserNickName")
    static let UserId = DefaultsKey<Int>("UserLoginId")
    static let MusicStatus = DefaultsKey<Int>("AppMusicStatus")
}

//保存的用户ID
var appUserIdSave: Int = 0
var appUserLogined: Bool = false
var appUserNickName: String?
var appMusicStatus: Int = 0
var appUserAvatar: String?
var appNetWorkStatus: Bool = false



let URL_MC = "http://wa.mckuai.com/interface.do?"

//上传头像/图片
let upload_url = URL_MC+"act=uploadImg"
let addTalk_url = URL_MC+"act=uploadQuestion"
let qqlogin_url = URL_MC+"act=login"

var player_bg = Player()
var player_click = Player()
let right_click = NSBundle.mainBundle().pathForResource("right", ofType: "mp3")!
let error_click = NSBundle.mainBundle().pathForResource("error", ofType: "mp3")!
let music_bg = NSBundle.mainBundle().pathForResource("background", ofType: "mp3")!

//PageInfo 用于下拉刷新
class PageInfo {
    var currentPage: Int = 0
    var pageCount: Int = 0
    var pageSize: Int = 0
    var allCount: Int = 0
    
    init(currentPage: Int, pageCount: Int, pageSize: Int, allCount: Int) {
        self.currentPage = currentPage
        self.pageCount = pageCount
        self.pageSize = pageSize
        self.allCount = allCount
    }
    
    init(j: JSON) {
        self.currentPage = j["page"].intValue
        self.pageCount = j["pageCount"].intValue
        self.pageSize = j["pageSize"].intValue
        self.allCount = j["allCount"].intValue
    }
}

class MCUtils {
    
    /**
    显示HUD提示框
    
    :param: view    要显示HUD的窗口
    :param: title   HUD的标题
    :param: imgName 自定义HUD显示的图片
    */
    class func showCustomHUD(VC: UIViewController, aMsg: String, aType: TSMessageNotificationType) {
        switch aType {
        case .Success:
            TSMessage.showNotificationInViewController(VC.navigationController, title: "成功", subtitle: aMsg, image: nil, type: aType, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
            //TSMessage.showNotificationWithTitle("操作成功", subtitle: aMsg, type: aType)
        case .Warning:
            TSMessage.showNotificationInViewController(VC.navigationController, title: "提示", subtitle: aMsg, image: nil, type: aType, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
            //TSMessage.showNotificationWithTitle("MC哇提示", subtitle: aMsg, type: aType)
        case .Error:
            TSMessage.showNotificationInViewController(VC.navigationController, title: "出错啦", subtitle: aMsg, image: nil, type: aType, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
//            TSMessage.showNotificationWithTitle("出错啦~!", subtitle: aMsg, type: aType)
        default:
            TSMessage.showNotificationInViewController(VC.navigationController, title: "消息", subtitle: aMsg, image: nil, type: aType, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
            //TSMessage.showNotificationWithTitle("消息", subtitle: aMsg, type: aType)
        }
        
    }
    
    
    /**
    保存用户配置信息
    
    :param: j JSON
    */
    class func AnalysisUserInfo(j: JSON) {
        let userId = j["id"].intValue
        let nickName = j["nickName"].stringValue
        let userAvatar = j["headImg"].stringValue
        //保存登录信息
        Defaults[DefaultsKeys.UserId] = userId
        Defaults[DefaultsKeys.NickName] = nickName
        Defaults[DefaultsKeys.UserAvater] = userAvatar
        Defaults[DefaultsKeys.logined] = true
        
        appUserIdSave = userId
        appUserNickName = nickName
        appUserAvatar = userAvatar
        appUserLogined = true

    }
    
    /**
     检查网络状态
     */
    class func checkNetWorkState(VC: UIViewController) -> Void {
        //网络状态
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock({st in
            switch st {
            case .ReachableViaWiFi:
                print("网络状态:WIFI")
                appNetWorkStatus = true
                //                TSMessage.showNotificationWithTitle("哇哦~", subtitle: "你在WIFI网络下面,随便畅玩吧", type: .Success)
            case .ReachableViaWWAN:
                print("网络状态:3G")
                appNetWorkStatus = true
                TSMessage.showNotificationInViewController(VC.navigationController, title: "警告!警告!", subtitle: "你正在使用流量上网,且玩且珍惜吧", image: nil, type: .Warning, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
            case .NotReachable:
                print("网络状态:不可用")
                appNetWorkStatus = false
                TSMessage.showNotificationInViewController(VC.navigationController, title: "出错啦~!", subtitle: "网络状态异常,请检查网络连接", image: nil, type: .Error, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
            default:
                print("网络状态:火星")
                appNetWorkStatus = false
                TSMessage.showNotificationInViewController(VC.navigationController, title: "出错啦~!", subtitle: "网络状态异常,请检查网络连接", image: nil, type: .Error, duration: 0, callback: nil, buttonTitle: nil, buttonCallback: nil, atPosition: .NavBarOverlay, canBeDismissedByUser: true)
            }
        })
        AFNetworkReachabilityManager.sharedManager().stopMonitoring()
    }

    

    /**
     UITableView 空数据时显示的类型
     
     :param: tv 要显示内容的TableView
     errorType: 1,空数据时; 2,加载失败
     */
    class func showEmptyView(tv: UITableView, aImg: UIImage, aText: String) {
        let v = UIView(frame: tv.frame)
        let img = UIImageView(image: aImg)
        let btnX = (v.bounds.size.width - img.bounds.size.width) / 2
        let btnY = (v.bounds.size.height - img.bounds.size.height - 70) / 2
        img.frame = CGRectMake(btnX, btnY, img.bounds.size.width, img.bounds.size.height)
        v.addSubview(img)
        
        let lb = UILabel(frame: CGRectMake(0, btnY+img.frame.size.height+10, v.bounds.size.width, 20))
        lb.text = aText
        lb.numberOfLines = 2;
        lb.textAlignment = .Center;
        lb.textColor = UIColor(hexString: "#9494CC")
        v.addSubview(lb)
        
        tv.backgroundView = v
        tv.separatorStyle = UITableViewCellSeparatorStyle.None
    }

}

/**
*  UIImage 扩展
*/
extension UIImage {
    
        enum AssetIdentifier : String {
            case Music_On = "music_on"
            case Music_Off = "music_off"
            
        }
        
        convenience init!(assetIdentifier : AssetIdentifier) {
            
            self.init(named: assetIdentifier.rawValue)
            
        }
        
    //通过颜色创建图片
    class func applicationCreateImageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let theImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return theImage
    }

}

//CALayer 扩展
extension CALayer {
    var borderUIColor: UIColor {
        get {
            return UIColor(CGColor: self.borderColor!)
        }
        set {
            self.borderColor = newValue.CGColor
        }
    }
}



