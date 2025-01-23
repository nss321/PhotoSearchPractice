//
//  UserDefaultsManager.swift
//  PhotoSearchPractice
//
//  Created by BAE on 1/23/25.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case isOnboarded
    }
    
    var isOnboarded: Bool {
        get {
            return userDefaults.bool(forKey: Key.isOnboarded.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.isOnboarded.rawValue)
        }
    }
}
