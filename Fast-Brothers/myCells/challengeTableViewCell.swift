//
//  challengeTableViewCell.swift
//  Fast-Brothers
//
//  Created by Nicolau Atala Pelluzi on 02/02/17.
//  Copyright © 2017 Nicolau Atala Pelluzi. All rights reserved.
//

import UIKit

class challengeTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var nameChallenge: UILabel!
    @IBOutlet weak var descriptionChallenge: UILabel!
    
    @IBOutlet weak var lockIcon: UIImageView!
    
    @IBOutlet weak var recordCell: UILabel!
    
    @IBOutlet weak var resultsCell: UILabel!

    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var local: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
