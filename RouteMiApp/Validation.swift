//
//  Validation.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation
import UIKit

class Validation {
    static func fieldValidation(_ field: UITextField, match: String, errorText: String, errorColor: UIColor) -> Bool {
        if field.text == match {
            DispatchQueue.main.async(execute: {
                field.attributedPlaceholder = AttributedString(string: errorText, attributes:[NSForegroundColorAttributeName: errorColor])
            })
            return false
        } else {
            return true
        }
    }
    
    static func passwordMatchValidation(_ passwordField: UITextField, confirmField: UITextField, errorText: String, errorColor: UIColor) -> Bool {
        if passwordField.text != confirmField.text {
            confirmField.text = ""
            DispatchQueue.main.async(execute: {
                confirmField.attributedPlaceholder = AttributedString(string: errorText, attributes:[NSForegroundColorAttributeName: errorColor])
            })
            return false
        } else {
            return true
        }
    }
    
    static func emailValidation(_ emailField: UITextField, errorText: String, errorColor: UIColor) -> Bool {
        do {
            let regex = try RegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
            if regex.firstMatch(in: emailField.text!, options: RegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, emailField.text!.characters.count)) == nil {
                emailField.text = ""
                DispatchQueue.main.async(execute: {
                    emailField.attributedPlaceholder = AttributedString(string: errorText, attributes:[NSForegroundColorAttributeName: errorColor])
                })
                return false
            } else {
                return true
            }
        } catch {
            return false
        }
    }
}
