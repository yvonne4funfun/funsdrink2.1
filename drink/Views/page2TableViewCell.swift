//
//  page2TableViewCell.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import UIKit

class page2TableViewCell: UITableViewCell {

    @IBOutlet weak var page2Detail: UILabel!
    @IBOutlet weak var page2Sugar: UILabel!
    @IBOutlet weak var page2Ice: UILabel!
    @IBOutlet weak var page2City: UILabel!
    @IBOutlet weak var page2Price: UILabel!
    @IBOutlet weak var page2Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
