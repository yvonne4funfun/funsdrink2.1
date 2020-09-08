//
//  page1TableViewCell.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import UIKit

class page1TableViewCell: UITableViewCell {

    @IBOutlet weak var page1Name: UILabel!
    @IBOutlet weak var page1Price: UILabel!
    @IBOutlet weak var page1Detail: UILabel!
    @IBOutlet weak var page1City: UILabel!
    @IBOutlet weak var page1Ice: UILabel!
    @IBOutlet weak var page1Sugar: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
