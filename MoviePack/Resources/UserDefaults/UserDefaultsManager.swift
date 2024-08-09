//
//  UserDefaultsManager.swift
//  MoviePack
//
//  Created by 서충원 on 8/9/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T> {
    
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get { UserDefaultsManager.shared.userdefaults.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaultsManager.shared.userdefaults.set(newValue, forKey: key) }
    }
}

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    
    private init() { }
    
    let userdefaults = UserDefaults.standard
    
    private enum Keys: String {
        case searchSort
    }
    
    // User
    @UserDefaultsWrapper(key: Keys.searchSort.rawValue, defaultValue: 2)
    var searchSort: Int
    
    func deleteAll() {
        for key in userdefaults.dictionaryRepresentation().keys {
            userdefaults.removeObject(forKey: key.description)
        }
    }
}
