//
//  Route.swift
//  RouteMiApp
//
//  Created by Teodor on 13/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation

enum RouteType {
    case walking
    case biking
    case driving
}

struct Route {
    let id: String?
    let name: String?
    let description: String?
    let type: RouteType?
    let createdAt: Date?
    let updatedAt: Date?
    
    init(jsonDictionary: [String: AnyObject]) {
        if let id = jsonDictionary["_id"] as? String {
            self.id = id
        } else {
            self.id = nil
        }
        if let name = jsonDictionary["name"] as? String {
            self.name = name
        } else {
            self.name = nil
        }
        if let description = jsonDictionary["description"] as? String {
            self.description = description
        } else {
            self.description = nil
        }
        if let type = jsonDictionary["type"] as? String {
            switch type {
            case "Walking":
                self.type = .walking
            case "Biking":
                self.type = .biking
            case "Driving":
                self.type = .driving
            default:
                self.type = .walking
            }
        } else {
            self.type = nil
        }
        if let createdAt = jsonDictionary["createdAt"] as? String {
            let formattedDate = Formatter.formatDate(createdAt)
            self.createdAt = formattedDate
        } else {
            self.createdAt = nil
        }
        if let updatedAt = jsonDictionary["updatedAt"] as? String {
            let formattedDate = Formatter.formatDate(updatedAt)
            self.updatedAt = formattedDate
        } else {
            self.updatedAt = nil
        }
    }
}
