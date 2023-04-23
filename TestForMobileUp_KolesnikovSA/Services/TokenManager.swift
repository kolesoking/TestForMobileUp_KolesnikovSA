//
//  TokenManager.swift
//  TestForMobileUp_KolesnikovSA
//
//  Created by Sergey Kolesnikov on 23.04.2023.
//

import Foundation

final class TokenManager {
    
    enum Key: String {
        case token
    }
    
    static var token: String! {
        get {
            UserDefaults.standard.string(forKey: Key.token.rawValue)
        } set {
            let defaults = UserDefaults.standard
            let key = Key.token.rawValue
            if let token = newValue {
                defaults.set(token, forKey: key)
            } else {
                defaults.removeObject(forKey: key)
            }
        }
    }
}
