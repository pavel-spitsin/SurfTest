//
//  AppDelegate.swift
//  SurfTest
//
//  Created by Павел on 01.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Properties
    
    var window: UIWindow?
    
    //MARK: - App Life Cycle
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseViewController(rootViewController: ProfileScreenView(viewModel: ProfileScreenViewModel()))
        window?.makeKeyAndVisible()
        return true
    }
}

