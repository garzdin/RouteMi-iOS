//
//  AccountViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 11/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthenticated()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.clipsToBounds = true
        getUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func getUserData() {
        RequestFactory.request("/account", type: .GET, headers: nil, addAPIKey: true, params: nil, completionHandler: {
            (result) in
            if let account = result["account"] as? [String: AnyObject] {
                let user = User(jsonDictionary: account)
                DispatchQueue.main.async(execute: {
                    self.profileImage.image = user.profileImage
                    if user.username != nil {
                        self.usernameLabel.text = user.username
                    }
                })
            }
        })
    }
    
    func checkAuthenticated() {
        let presentingViewController: UIViewController! = self.presentingViewController
        if (Constants.keychain["apiKey"] == nil) {
            self.dismiss(animated: true, completion: {
                presentingViewController.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func logoutAction(_ sender: UIBarButtonItem) {
        Actions.logoutUser()
        self.checkAuthenticated()
    }
}
