//
//  TableCellTableViewCell.swift
//  iQuiz
//
//  Created by Sarthak Turkhia on 10/29/18.
//  Copyright © 2018 Sarthak Turkhia. All rights reserved.
//

import UIKit

class TableCellTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
