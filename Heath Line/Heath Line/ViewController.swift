//
//  ViewController.swift
//  Heath Line
//
//  Created by Jennifer Lopez on 4/12/22.
//

import UIKit

class ViewController: UIViewController {
    


    @IBAction func createAccount(_ sender: Any) {
        self.performSegue(withIdentifier: "CreateAccount", sender: nil)

    }
    @IBAction func login(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

