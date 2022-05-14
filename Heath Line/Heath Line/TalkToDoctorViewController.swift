//
//  TalkToDoctorViewController.swift
//  Heath Line
//
//  Created by Jennifer Lopez on 4/26/22.
//

import UIKit
import Firebase
import Foundation

class TalkToDoctorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var email:String = ""
    let db = Firestore.firestore()
    //    let dropDown = DropDown()
    var id = 0
    var name:String = ""
    var doctorDict:[String:Any] =  [
            "name": "Dr. Reema Menezes, MD",
            "address": "9460 N Name Uno Ste 110",
            "city": "Gilroy",
            "zipcode": "95020",
            "profession": "Doctor",
            "state": "Ca",
            "id": "1"]
    var doctorDic2:[String:Any] = [
        "name": "Dr. Ray, MD",
        "address": "9460 Forest Ste 110",
        "city": "Gilroy",
        "zipcode": "95020",
        "profession": "Doctor",
        "state": "Ca",
        "id": "2"]
    
    var doctorDic3:[String:Any] = [
        "name": "Dr. May, MD",
        "address": "120 Star Street Uno Ste 110",
        "city": "Gilroy",
        "zipcode": "95020",
        "profession": "Doctor",
        "state": "Ca",
        "id": "3"]
    var doctorDic4:[String:Any] = [
        "name": "Dr. Reema Menezes, MD",
        "address": "9460 N Name Uno Ste 110",
        "city": "Gilroy",
        "zipcode": "95020",
        "profession": "Doctor",
        "state": "Ca",
        "id": "4"]
    var doctorDic5:[String:Any] = [
        "name": "Dr. Nancy, MD",
        "address": "9460 T0 Blvd",
        "city": "Gilroy",
        "zipcode": "95020",
        "profession": "Doctor",
        "state": "Ca",
        "id": "1"]
    var doctorDic6:[String:Any] = [
        "name": "Dr. Nancy, MD",
        "address": "9460 T0 Blvd",
        "city": "Morgan Hill",
        "zipcode": "95012",
        "profession": "Doctor",
        "state": "Ca",
        "id": "1"]
    var doctorDic7:[String:Any] = [
        "name": "Dr. Nancy, MD",
        "address": "9460 T0 Blvd",
        "city": "San Jose",
        "zipcode": "95223",
        "profession": "Doctor",
        "state": "Ca",
        "id": "1"]
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var zipCodeLabel: UITextField!
    @IBAction func returnHome(_ sender: Any) {
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                let data = document.data()
                print(data as Any)
                self.performSegue(withIdentifier: "returnHome", sender: document)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(email)
        //import PlaygroundSupport
        print(doctorDict["zipcode"])
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                let data = document.data()
                zipCodeLabel.text = data!["zipcode"] as? String
            }
        }
        let url = URL(string: "https://627ecd1eb75a25d3f3bd3d78.mockapi.io/doctors/1")!
        let request = URLRequest(url: url)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          if let response = response {
              print(response)

            if let data = data, let body = String(data: data, encoding: .utf8) {
                print("pass")
            }
          } else {
            print(error ?? "Unknown error")
          }
        }

        task.resume()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    @IBAction func searchDoctor(_ sender: Any) {
        self.tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doctorDict.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell") as! DoctorCell
        print(doctorDict["zipcode"])
        if(doctorDict["zipcode"] as! String == zipCodeLabel.text){
            cell.doctorName.text = doctorDict["name"] as! String
            let x:String = doctorDict["address"] as! String
            let b :String = doctorDict["city"] as! String
            let y : String = doctorDict["state"] as! String
            let a : String = doctorDict["zipcode"] as! String
            cell.doctorAddress.text = x + " " + b + " " + y + " " + a
        }else if(doctorDic6["zipcode"] as! String == zipCodeLabel.text){
            cell.doctorName.text = doctorDict["name"] as! String
            let x:String = doctorDic6["address"] as! String
            let b :String = doctorDic6["city"] as! String
            let y : String = doctorDic6["state"] as! String
            let a : String = doctorDic6["zipcode"] as! String
            cell.doctorAddress.text = x + " " + b + " " + y + " " + a
        }else if(doctorDic7["zipcode"] as! String == zipCodeLabel.text){
            cell.doctorName.text = doctorDict["name"] as! String
            let x:String = doctorDic7["address"] as! String
            let b :String = doctorDic7["city"] as! String
            let y : String = doctorDic7["state"] as! String
            let a : String = doctorDic7["zipcode"] as! String
            cell.doctorAddress.text = x + " " + b + " " + y + " " + a
        }
        return cell
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
