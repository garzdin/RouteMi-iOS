//
//  Constants.swift
//  RouteMiApp
//
//  Created by Teodor on 11/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation
import KeychainAccess

struct Constants {
    static let keychain: Keychain = Keychain(service: "com.teodorgarzdin.routemiapp")
    static let endpoint: URL = URL(string: "https://routemiapi.herokuapp.com/")!
}
