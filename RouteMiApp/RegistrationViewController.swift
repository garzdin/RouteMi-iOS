//
//  RegistrationViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func registerAction(_ sender: UIButton) {
        if Validation.fieldValidation(self.usernameField, match: "", errorText: "Enter a username", errorColor: .red()) && Validation.fieldValidation(self.passwordField, match: "", errorText: "Enter a password", errorColor: .red()) && Validation.fieldValidation(self.confirmPasswordField, match: "", errorText: "Confirm your password", errorColor: .red()) && Validation.fieldValidation(self.emailField, match: "", errorText: "Enter an email", errorColor: .red()) && Validation.passwordMatchValidation(self.passwordField, confirmField: self.confirmPasswordField, errorText: "Password do not match", errorColor: .red()) && Validation.emailValidation(self.emailField, errorText: "Email is not valid", errorColor: .red()) {
            let params: [String: AnyObject] = [
                "username": self.usernameField.text!,
                "password": self.passwordField.text!,
                "email": self.emailField.text!
            ]
            RequestFactory.request("/account/create", type: .POST, headers: nil, addAPIKey: false, params: params, completionHandler: {
                (result) in
                if let success = result["success"] as? Bool {
                    if success == true {
                        MessageService.sendButtonMessage(self.submitButton, enabled: false, message: "ACCOUNT CREATED", state: .disabled, color: UIColor(red: 128.0/255.0, green: 204.0/255.0, blue: 26.0/255.0, alpha: 1.0), textFieldsDisable: [self.usernameField, self.passwordField, self.confirmPasswordField, self.emailField])
                    }
                }
            })
        }
        
    }
    
    @IBAction func minimizeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
