//
//  Actions.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation

class Actions {
    static func logoutUser() {
        do {
            try Constants.keychain.remove("apiKey")
        } catch let error {
            print("error: \(error)")
        }
    }
}