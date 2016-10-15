//
//  User.swift
//  RouteMiApp
//
//  Created by Teodor on 11/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

struct User {
    let username: String?
    let email: String?
    let firstName: String?
    let lastName: String?
    let profileImage: UIImage?
    let lastKnownLocation: CLLocationCoordinate2D?
    let isActive: Bool?
    let lastActive: Date?
    
    init(jsonDictionary: [String: AnyObject]) {
        if let username = jsonDictionary["username"] as? String {
            self.username = username
        } else {
            self.username = nil
        }
        if let email = jsonDictionary["email"] as? String {
            self.email = email
        } else {
            self.email = nil
        }
        if let firstName = jsonDictionary["firstName"] as? String {
            self.firstName = firstName
        } else {
            self.firstName = nil
        }
        if let lastName = jsonDictionary["lastName"] as? String {
            self.lastName = lastName
        } else {
            self.lastName = nil
        }
        if let profilePicture = jsonDictionary["profileImage"] as? [String: AnyObject] {
            if let data = profilePicture["data"] as? [UInt] {
                self.profileImage = UIImage(data: Data(bytes: UnsafePointer<UInt8>(data.flatMap{UInt8($0)}), count: data.count), scale: 1.0)
            } else {
                self.profileImage = nil
            }
        } else {
            self.profileImage = nil
        }
        if let lastKnownLocation = jsonDictionary["lastKnownLocation"] as? CLLocationCoordinate2D {
            self.lastKnownLocation = lastKnownLocation
        } else {
            self.lastKnownLocation = nil
        }
        if let isActive = jsonDictionary["isActive"] as? Bool {
            self.isActive = isActive
        } else {
            self.isActive = nil
        }
        if let lastActive = jsonDictionary["lastActive"] as? Date {
            self.lastActive = lastActive
        } else {
            self.lastActive = nil
        }
    }
}
