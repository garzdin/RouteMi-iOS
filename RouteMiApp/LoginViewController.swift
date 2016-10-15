//
//  LoginViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 11/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var minimizeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func loginAction(_ sender: UIButton) {
        if Validation.fieldValidation(self.usernameField, match: "", errorText: "Enter a username", errorColor: .red()) && Validation.fieldValidation(self.passwordField, match: "", errorText: "Enter a password", errorColor: .red()) {
            let params: [String: AnyObject] = [
                "username": usernameField.text!,
                "password": passwordField.text!
            ]
            RequestFactory.request("/authenticate", type: .POST, headers: nil, addAPIKey: false, params: params, completionHandler: {
                (result) in
                if let success = result["success"] as? Bool {
                    if success == true {
                        if let apiKey = result["token"] as? String {
                            do {
                                try Constants.keychain.set(apiKey, key: "apiKey")
                            }
                            catch let error {
                                print("Error \(error)")
                            }
                            OperationQueue.main().addOperation {
                                self.performSegue(withIdentifier: "loginSuccessful", sender: self)
                            }
                        }
                    } else {
                        if let message = result["message"] as? String {
                            if message.range(of: "User not found") != nil {
                                MessageService.sendInputMessage(self.usernameField, messageText: "User not found", messageColor: .red(), fieldsToReset: [self.usernameField, self.passwordField])
                            }
                            if message.range(of: "Wrong password") != nil {
                                MessageService.sendInputMessage(self.passwordField, messageText: "Wrong password", messageColor: .red(), fieldsToReset: [self.passwordField])
                            }
                        }
                    }
                }
            })
        }
    }
    
    @IBAction func minimizeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
