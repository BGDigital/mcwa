//
//  AppDelegate.swift
//  mcwa
//
//  Created by XingfuQiu on 15/10/8.
//  Copyright © 2015年 XingfuQiu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        //友盟分享
        UMSocialData.setAppKey(UMAppKey)
        UMSocialQQHandler.setQQWithAppId(qq_AppId, appKey: qq_AppKey, url: share_url)
        UMSocialWechatHandler.setWXAppId(wx_AppId, appSecret: wx_AppKey, url: share_url)
        UMSocialConfig.hiddenNotInstallPlatforms(shareToNames)
        
        // 友盟统计 nil为空时 默认appstore渠道 不同渠道 统计数据都算到第一个安装渠道
        MobClick.startWithAppkey(UMAppKey, reportPolicy: BATCH, channelId: nil)
        //版本号
        let infoDictionary = NSBundle.mainBundle().infoDictionary
        let majorVersion: AnyObject? = infoDictionary!["CFBundleShortVersionString"]
        let appversion = majorVersion as! String
        MobClick.setAppVersion(appversion)
        MobClick.setLogEnabled(true)//集成测试
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        var result:Bool = UMSocialSnsService.handleOpenURL(url);
        if (result == false) {
            //调用其他SDK，例如新浪微博SDK等
            result =  TencentOAuth.HandleOpenURL(url)
            
        }
        return result
        
    }
    
    func application(application:UIApplication,handleOpenURL url:NSURL) -> Bool {
        var result:Bool = UMSocialSnsService.handleOpenURL(url);
        if (result == false) {
            //调用其他SDK，例如新浪微博SDK等
            result =  TencentOAuth.HandleOpenURL(url)
            
        }
        return result
    }


}

