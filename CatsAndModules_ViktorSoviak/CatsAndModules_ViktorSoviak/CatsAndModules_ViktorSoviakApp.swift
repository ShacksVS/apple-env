//
//  CatsAndModules_ViktorSoviakApp.swift
//  CatsAndModules_ViktorSoviak
//
//  Created by Viktor Sovyak on 5/20/24.
//

import SwiftUI
import FirebaseCore
import FirebaseCrashlytics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(false)
        
    return true
    }
}

@main
struct CatsAndModules_ViktorSoviakApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            CatList()
        }
    }
}
