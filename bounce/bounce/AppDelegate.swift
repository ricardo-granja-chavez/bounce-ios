//
//  AppDelegate.swift
//  bounce
//
//  Created by Ricardo Granja Chávez on 20/01/24.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = PlaneViewController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
}
