//
//  AppDelegate.swift
//  TemplateMVVM
//
//  Created by Ahmed Nour on 4/15/21.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
var window: UIWindow?
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    window = UIWindow(frame: UIScreen.main.bounds)
    let navigationController = UINavigationController(rootViewController: CurrencyListViewController())
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    IQKeyboardManager.shared.enable = true
    return true
  }


}

