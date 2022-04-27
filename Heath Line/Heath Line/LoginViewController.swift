//
//  LoginViewController.swift
//  Heath Line
//
//  Created by Jennifer Lopez on 4/19/22.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    var username: String = ""
    let db = Firestore.firestore()
    var emailInfo: String = ""
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    
    @IBAction func loginBtn(_ sender: Any) {
        let userName = usernameText.text?.trimmingCharacters(in: .whitespaces)
        let password = passwordText.text?.trimmingCharacters(in: .whitespaces)
        if(userName != "" && password != ""){
            let docRef = db.collection("Users").document(userName!)
            docRef.getDocument{(document, error) in
                if let document = document, document.exists {
                    self.username = userName!
                    let data = document.data()
                    let passwordStored = data?["password"]
                    
                    if(password == passwordStored as? String){
                        print(document)
                        self.emailInfo = userName ?? ""
                        self.performSegue(withIdentifier: "HomePage", sender: document)
                    }else{
                        let alert = UIAlertController(title: "Error", message: "Password is not correct", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }else{
                    let alert = UIAlertController(title: "Error", message: "Email doesn't exist", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }else{
            if(userName == "" || password == ""){
                let alert = UIAlertController(title: "Error", message: "Email/Password is empty", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Error", message: "Not valid email", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func isValidEmail(emailID:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("page")
        if(segue.identifier == "HomePage"){
            let destinationVC = segue.destination as! HomeViewController
            destinationVC.email = emailInfo
            print(emailInfo)
        }
        
    }

}
