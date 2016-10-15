//
//  MessageService.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import Foundation
import UIKit

class MessageService {
    static func sendButtonMessage(_ button: UIButton, enabled: Bool, message: String, state: UIControlState, color: UIColor, textFieldsDisable: [UITextField]?) {
        if let fields = textFieldsDisable as [UITextField]? {
            for field in fields {
                DispatchQueue.main.async(execute: {
                    field.text = ""
                    field.isUserInteractionEnabled = false
                })
            }
        }
        DispatchQueue.main.async(execute: {
            button.isEnabled = enabled
            button.setTitle(message, for: state)
            button.backgroundColor = color
        })
    }
    
    static func sendInputMessage(_ field: UITextField, messageText: String, messageColor: UIColor, fieldsToReset: [UITextField]) {
        if let fields = fieldsToReset as [UITextField]? {
            for field in fields {
                DispatchQueue.main.async(execute: {
                    field.text = ""
                })
            }
        }
        DispatchQueue.main.async(execute: {
            field.attributedPlaceholder = AttributedString(string: messageText, attributes:[NSForegroundColorAttributeName: messageColor])
        })
    }
}
