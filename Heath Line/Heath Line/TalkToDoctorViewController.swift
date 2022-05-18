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
    var count = 1
    var email:String = ""
    let db = Firestore.firestore()
    //    let dropDown = DropDown()
    var id = 0
    var index = 0
    var name:String = ""
    var interestingNumbers = [1: ["name":"Dr. Reema Menezes, MD",
                                    "direction":"9460 N Name Uno Ste 110 Gilroy 95020 Ca",
                                    "zipcode": "95020"],
                              2: ["name":"Dr. Ray, MD",
                                    "direction":"9460 Forest Ste 110 Gilroy 95020 Ca",
                                    "zipcode": "95020"],
                              3:["name":"Dr. May, MD",
                                   "direction":"120 Star Street Uno Ste 110 Gilroy 95020 Ca",
                                   "zipcode": "95020"],
                              4:["name":"Dr. Reema Menezes, MD",
                                   "direction":"9460 N Name Uno Ste 110 Gilroy 95020 Ca",
                                   "zipcode": "95020"],
                              5:["name":"Dr. Nancy, MD",
                                   "direction":"9460 T0 Blvd Gilroy 95020 Ca",
                                   "zipcode": "95020"],
                              6:["name":"Dr. Nancy, MD",
                                   "direction":"9460 T0 Blvd Morgan Hill 95012 Ca",
                                   "zipcode": "95012"],
                              7: ["name":"Dr. Nancy, MD",
                                    "direction":"9460 T0 Blvd San Jose 95223 Ca",
                                    "zipcode": "95223"]]

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
        let docRef = db.collection("Users").document(email)
        docRef.getDocument{ [self](document, error) in
            if let document = document, document.exists {
                let data = document.data()
                zipCodeLabel.text = data!["zipcode"] as? String
            }

        }
//        let url = URL(string: "https://627ecd1eb75a25d3f3bd3d78.mockapi.io/doctors/1")!
//        let request = URLRequest(url: url)
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//          if let response = response {
//              print(response)
//
//            if let data = data, let body = String(data: data, encoding: .utf8) {
//                print("pass")
//            }
//          } else {
//            print(error ?? "Unknown error")
//          }
//        }

//        task.resume()
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    @IBAction func searchDoctor(_ sender: Any) {
//        for key in interestingNumbers.keys {
//            interestingNumbers[key]?.sort(by: >)
//        }
        index = 0
        for i in 1...7{
            if(interestingNumbers[i]!["zipcode"]! == zipCodeLabel.text){
               index += 1
            }
        }
        print("inex foun")
        print(index)
        i(x: "pass")
        //self.tableview.reloadData()
    }
    
    func i(x: String){
        self.tableview.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorCell") as! DoctorCell
        print("passssss")
        print(count)
        print(zipCodeLabel.text)
        if(index > 1){
            if(interestingNumbers[count]!["zipcode"]! == zipCodeLabel.text){
                print(interestingNumbers[count]?["direction"]!)
                cell.doctorName.text = interestingNumbers[count]?["name"] as! String
                cell.doctorAddress.text = interestingNumbers[count]?["direction"]!
                count += 1
            }else{
                count += 1
            }
        }else{
            for i in 1...7{
                print("hhhh")
                print(interestingNumbers[i]?["direction"]!)
                if(interestingNumbers[i]!["zipcode"]! == zipCodeLabel.text){
                    print(interestingNumbers[i]?["direction"]!)
                    cell.doctorName.text = interestingNumbers[i]?["name"] as! String
                    cell.doctorAddress.text = interestingNumbers[i]?["direction"]!
                }
            }
        }
        if(count == 8){
            count = 1
        
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
