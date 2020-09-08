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
    
    var filteredOrderDetails = [Download]()



    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(with: [Download],for cell: showTableViewCell, at row:Int){
        let potentialOrderDetail = filteredOrderDetails[row]

        cell.orderName.text = potentialOrderDetail.name
        cell.orderDrink.text = potentialOrderDetail.drink
        cell.orderPrice.text = "\(potentialOrderDetail.price)"
        cell.orderIce.text = potentialOrderDetail.ice
        cell.orderSugar.text = potentialOrderDetail.sugar
        cell.orderTime.text = potentialOrderDetail.date
        cell.orderCup.text = potentialOrderDetail.size
        cell.orderTime.text = potentialOrderDetail.date
        
    }
    
    func configureCell(data: Download){
        orderName.text = data.name
        orderDrink.text = data.drink
        orderPrice.text = "\(data.price)"
        orderIce.text = data.ice
        orderSugar.text = data.sugar
        orderTime.text = data.date
        orderCup.text = data.size
        orderTime.text = data.date
        
    }

}
