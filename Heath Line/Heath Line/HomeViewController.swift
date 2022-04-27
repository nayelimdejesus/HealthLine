//
//  HomeViewController.swift
//  Heath Line
//
//  Created by Nayeli De Jesus on 4/18/22.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    var email:String = ""
    let db = Firestore.firestore()
    @IBOutlet weak var userName: UILabel!
    @IBAction func talkToDoctor(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                self.performSegue(withIdentifier: "TalkToDoctor", sender: document)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let name = data?["first_name"]
                self.userName.text = (name as! String) + "!"
            }
        }
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
        if(segue.identifier == "TalkToDoctor"){
            let destinationVC = segue.destination as! TalkToDoctorViewController
            destinationVC.email = email
        }
    }
}
