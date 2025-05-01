//
//  AppDelegate.swift
//  Marvel Comic
//
//  Created by Kevin Costa on 25/8/21.
//  Copyright © 2021 Marvel Comic. All rights reserved.
//

import UIKit
import CoreData

enum RotationType {
    case unknown, portrait, landscapeLeft, landscapeRight, portraitUpsideDown, landscape, all, allButUpsideDown
}

struct Message: Codable {
    var id: Int
    var type: TypeMessage
}

struct MessageVideo: Codable {
    var duration: Int
    var url: String
}

struct MessageImage: Codable {
    var size: Double
    var url: String
}

enum TypeMessage: Codable {
    case video(obj: MessageVideo)
    case image(obj: MessageImage)
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var restrictRotation: RotationType = .portrait

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        window?.rootViewController = CharacterListConfigurator.prepareView()
        window?.makeKeyAndVisible()
        
        return true
    }

}
