//
//  AffordableViewController.swift
//  Heath Line
//
//  Created by Nayeli De Jesus on 5/11/22.
//

import UIKit
import Firebase

class AffordableViewController: UIViewController {
    var email:String = ""
    let db = Firestore.firestore()
    @IBAction func returnHome(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                self.performSegue(withIdentifier: "returnHome", sender: document)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "returnHome"){
            let destinationVC = segue.destination as! HomeViewController
            destinationVC.email = email
        }
    }

}
