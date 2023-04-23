//
//  AppDelegate.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 20.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        TokenManager.token = ""
        if !TokenManager.token.isEmpty {
            window?.rootViewController = GalleryViewController()
        } else {
            window?.rootViewController = MainViewController()
        }
        
        return true
    }
}

