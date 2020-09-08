//
//  page3TableViewCell.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import UIKit

class page3TableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var page3Detail: UILabel!
    @IBOutlet weak var page3Price: UILabel!
    @IBOutlet weak var page3Name: UILabel!
    @IBOutlet weak var page3City: UILabel!
    @IBOutlet weak var page3Ice: UILabel!
    @IBOutlet weak var page3Sugar: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
