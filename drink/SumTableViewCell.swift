//
//  SumTableViewCell.swift
//  drink
//
//  Created by fun on 2020/8/31.
//

import UIKit

class SumTableViewCell: UITableViewCell {

    @IBOutlet weak var sumCups: UILabel!
    @IBOutlet weak var sumPrice: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
