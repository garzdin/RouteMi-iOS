//
//  RestorePasswordViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class RestorePasswordViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func restoreAction(_ sender: UIButton) {
        if Validation.fieldValidation(self.emailField, match: "", errorText: "Enter an email", errorColor: .red()) && Validation.emailValidation(self.emailField, errorText: "Email is not valid", errorColor: .red()) {
            let params: [String: AnyObject] = [
                "email": emailField.text!
            ]
            RequestFactory.request("/account/reset", type: .POST, headers: nil, addAPIKey: false, params: params, completionHandler: {
                (result) in
                if let success = result["success"] as? Bool {
                    if success == true {
                        MessageService.sendButtonMessage(self.submitButton, enabled: false, message: "EMAIL SENT", state: .disabled, color: UIColor(red: 128.0/255.0, green: 204.0/255.0, blue: 26.0/255.0, alpha: 1.0), textFieldsDisable: [self.emailField])
                    }
                }
            })
        }
    }
    
    @IBAction func minimizeAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
