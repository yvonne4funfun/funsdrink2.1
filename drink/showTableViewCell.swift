//
//  showTableViewCell.swift
//  drink
//
//  Created by fun on 2020/8/21.
//

import UIKit

class showTableViewCell: UITableViewCell {

    @IBOutlet weak var orderCup: UILabel!
    @IBOutlet weak var orderName: UILabel!
    @IBOutlet weak var orderDrink: UILabel!
    @IBOutlet weak var orderSugar: UILabel!
    @IBOutlet weak var orderIce: UILabel!
    @IBOutlet weak var orderTime: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    
  //  func updateUI(){
  //      orderName.text = .name
  //      orderDrink.text = cellinformation.drink
    //      orderTime.text = cellinformation.date
    //  orderPrice.text = "\(cellinformation.price)"
    //  orderSugar.text = cellinformation.sugar
    //  orderIce.text = cellinformation.ice}

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
