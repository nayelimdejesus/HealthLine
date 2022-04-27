//
//  TalkToDoctorViewController.swift
//  Heath Line
//
//  Created by Jennifer Lopez on 4/26/22.
//

import UIKit
import Firebase


class TalkToDoctorViewController: UIViewController {
    var email:String = ""
    let db = Firestore.firestore()
//    let dropDown = DropDown()

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
        
    }
    
//    @IBAction func selectProfession(_ sender: Any) {
//        dropDown.dataSource = [""]
//    }
    
    //
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "returnHome"){
            let destinationVC = segue.destination as! HomeViewController
            destinationVC.email = email
        }
    }
}
