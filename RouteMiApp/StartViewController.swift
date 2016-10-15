//
//  StartViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 12/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkAuthenticated()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkAuthenticated() {
        if (Constants.keychain["apiKey"] != nil) {
            performSegue(withIdentifier: "authenticationNotNeeded", sender: self)
        }
    }
}
