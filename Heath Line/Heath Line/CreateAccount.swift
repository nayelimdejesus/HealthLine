//
//  CreateAccount.swift
//  Heath Line
//
//  Created by Jennifer Lopez on 4/19/22.
//

import UIKit
import Firebase

class CreateAccount: UIViewController {
    
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var insurance: UITextField!
    @IBOutlet weak var zip: UITextField!
    let db = Firestore.firestore()
    var userinfo: String = ""
    @IBAction func signUp(_ sender: Any) {
        let FirstName = firstName.text?.trimmingCharacters(in: .whitespaces)
        let LastName = lastName.text?.trimmingCharacters(in: .whitespaces)
        let Username = username.text?.trimmingCharacters(in: .whitespaces)
        let Password = password.text?.trimmingCharacters(in: .whitespaces)
        let insuranceComp = insurance.text?.trimmingCharacters(in:.whitespaces)
        let zipCodeInfo = zip.text?.trimmingCharacters(in:.whitespaces)
        
        if(Username != "" && Password != ""){
            let docRef = db.collection("Users").document(Username!)
            
            docRef.getDocument{ (document, error) in
                if let document = document, document.exists {
                    let alert = UIAlertController(title: "Error", message: "Email already exisits", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    self.db.collection("Users").document(self.username.text!).setData([
                        "first_name": FirstName!,
                        "last_name": LastName!,
                        "password": Password!,
                        "insurance": insuranceComp!,
                        "zipcode": zipCodeInfo!
                    ]){ (err) in
                        if let err = err {
                            print("Error writing document: \(err)")
                        } else {
                            print("Document successfully written!!")
                            let doc = self.db.collection("Users").document(Username!)
                            doc.getDocument {(document, error) in
                                if let document = document, document.exists {
                                    self.userinfo = Username!
                                    print(document)
                                    self.performSegue(withIdentifier: "loginTest", sender: document)
                                }
                            }
                        }
                    }
                }
            }
                
            
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    func isVaildEmail(username: String) -> Bool{
        let usernameRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let usernameTest = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernameTest.evaluate(with: username)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if(segue.identifier == "loginTest"){
            let destinationVC = segue.destination as! LoginViewController
            destinationVC.username = userinfo
        }
    }
}
