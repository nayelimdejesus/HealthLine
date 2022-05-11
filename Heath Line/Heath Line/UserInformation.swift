//
//  UserInformation.swift
//  Heath Line
//
//  Created by Nayeli De Jesus on 4/27/22.
//

import UIKit
import Firebase

class UserInformation: UIViewController {
    var email:String = ""
    let db = Firestore.firestore()
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let docRef = db.collection("Users").document(email)
//        let destinationVC = segue.destination as! HomeViewController
//        destinationVC.email = emailInfo
//        print(emailInfo)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                let data = document.data()
                let name = data?["first_name"]
                let lastName = data?["last_name"]
//                print(db.collection("Users").document(email))
//                let email = db.collection("Users").document(email)
//                let email = data?["email"]
                print(email)
                self.firstName.text = (name as! String)
                self.lastName.text = (lastName as! String)
                self.emailAddress.text = (email)
                
            }
        }

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

}
