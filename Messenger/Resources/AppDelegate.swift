//
//  AppDelegate.swift
//  Messenger
//
//  Created by HieuTong on 3/22/21.
//

import UIKit
import Firebase
import UIKit
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application( _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? ) -> Bool {
        FirebaseApp.configure()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = TabBarViewController()
        window.makeKeyAndVisible()
        self.window = window
        ApplicationDelegate.shared.application( application, didFinishLaunchingWithOptions: launchOptions )
        return true
    }
    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool { ApplicationDelegate.shared.application( app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: options[UIApplication.OpenURLOptionsKey.annotation] )
    }
}
    
