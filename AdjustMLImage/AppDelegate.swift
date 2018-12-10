//
//  AppDelegate.swift
//  AdjustMLImage
//
//  Created by 국윤수 on 06/12/2018.
//  Copyright © 2018 국윤수. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions
		launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

		self.window = UIWindow(frame: UIScreen.main.bounds)

		let initialViewController = MainViewController()
		let nav = UINavigationController(rootViewController: initialViewController)

		self.window?.rootViewController = nav
		self.window?.makeKeyAndVisible()

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {

	}

	func applicationDidEnterBackground(_ application: UIApplication) {
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
	}

	func applicationWillTerminate(_ application: UIApplication) {
	}

}
