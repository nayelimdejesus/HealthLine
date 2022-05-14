//
//  DoctorCell.swift
//  Heath Line
//
//  Created by Jennifer Lopez on 5/14/22.
//

import Foundation
import UIKit

class DoctorCell: UITableViewCell{
    
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
