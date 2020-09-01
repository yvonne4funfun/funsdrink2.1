//
//  editTableViewController.swift
//  drink
//
//  Created by fun on 2020/8/22.
//

import UIKit

class editTableViewController: UITableViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bubbleSwitch: UISwitch!
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var sugar: UISegmentedControl!
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
 
    var orders:[Order]=[]
    var drinks:[Drink]=[]
    var orderList:List!
    var teaorder = TeaChoicesData ()

    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dowmLoadMenu()
        if let orderList = orderList{
            nameTextField.text = orderList.name
            priceLabel.text = "\(orderList.price)"
            drinkButton.setTitle("\(orderList.drink)", for: .normal)
            drinkButton.setTitleColor(UIColor.black, for: .normal)
            
            
            
        }
    }
    //如果換飲料就更新容量為中杯
    func updateSizeSegmentedControl(){
          size.selectedSegmentIndex = 0
    }
    
 
   
    func dowmLoadMenu(){
        //下載菜單的資訊
         if let url = URL(string:"https://sheetdb.io/api/v1/n4oty7ptgbfj7") {
                    let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data {
                            do{
                            let drinkData = try decoder.decode([Drink].self, from: data)
                            print(drinkData.count)
                                for i in 0...drinkData.count - 1 {
                                 //陣列從0開始故減1
                                    let priceInt:Int = Int(drinkData[i].mPrice!)!
                                    //在這邊將價格轉型以利後面價錢計算
                                 let brand = drinkData[i].brand
                                    let drink = drinkData[i].name
                                    if brand == "約翰紅茶公司" {
                                     let drinkName = "\(drink)"
                                     let oneOrder = Order(orderDrink: "\(drinkName)",orderPrice: priceInt)
                                      self.orders.append(oneOrder)
                                    }
                                }
                            }
                            catch{
                                print(error)
                            }
                        }
                        //print(self.orders.count)
                    }
                    task.resume()
                }
         

         
         
    }
        
        
        

    
    
    
   
    // MARK: - Table view data source

 

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func drinkButton(_ sender: UIButton) {
        
        let name = ["錫金紅茶","夢幻紅茶","珍珠那提","抹茶那提","煮濃那提","生乳紅茶","糖檸紅茶","玉釀紅茶","冰淇淋紅茶"]
        updateSizeSegmentedControl()
        
        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for drink in orders {
            let action = UIAlertAction(title: drink.orderDrink, style: .default) { (_) in
            sender.setTitleColor(UIColor.black, for: .normal)
                sender.setTitle(drink.orderDrink, for: .normal)
                self.priceLabel.text = "＄\(drink.orderPrice)"
                //點選飲料priceLabel顯示對印的價格
                
                
                if name.contains(drink.orderDrink) {
                    self.size.setEnabled(false, forSegmentAt: 1)
                    self.priceLabel.text = "＄\(drink.orderPrice)只有中杯唷！"
                }else{
                    self.size.setEnabled(true, forSegmentAt: 1)
                }//若選到這些飲料只有中杯，大杯的segment選項會失效
                
            }
            controller.addAction(action)
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
    }
        

        
        

    
    
    @IBAction func sentButton(_ sender: UIButton) {
        showAlert()
        sendDrinksOrderToServer()
    }
    
    
    func showAlert(){
        if nameTextField.text?.isEmpty == true {
            let controller = UIAlertController(title: "請填入名字", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
            return
        }else{
            if  drinkButton.titleColor(for: .normal) == UIColor.black{
                tabBarController?.selectedIndex = 2
                //點選按鈕若成功會跳轉到tabbar第三頁


            }else{
                let controller = UIAlertController(title: "請選擇飲料", message: nil, preferredStyle: .alert)
                controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                present(controller, animated: true, completion: nil)
                return
            }
        
    }
        
    }
    
    

    
    //傳送訂單資料至sheetDB
    func sendDrinksOrderToServer() {
        
        
            //POST的API需要知道上傳的資料是什麼格式，所以依照API Documentation的規定設定
            let url = URL(string: "https://sheetdb.io/api/v1/u2r459ric9akb")
            var urlRequest = URLRequest(url: url!)
            // 上傳資料所以設定為POST
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            //post所提供的API，Value為物件的陣列（Array），所以利用Dictionary實作
        let confirmOrder: [String : Any] = ["date":teaorder.date,"name": teaorder.name, "drink": teaorder.drink, "size": teaorder.size,"price": teaorder.price ,"sugar": teaorder.sugar.rawValue, "ice": teaorder.ice.rawValue]
            
            //Post API 需要在物件（Object）內設定key值為data, value為一個物件的陣列（Array）
            let postData: [String: Any] = ["data" : confirmOrder]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: postData, options: []) // 將Data轉為JSON格式
                let task = URLSession.shared.uploadTask(with: urlRequest, from: data) { (retData, res, err) in // 背景上傳資料
                    NotificationCenter.default.post(name: Notification.Name("waitMessage"), object: nil, userInfo: ["message": true])
                }
                task.resume()
            }
            catch{
            }
        }
    
    @IBAction func sizeSegmentControl(_ sender: UISegmentedControl) {
        if size.selectedSegmentIndex == 1 {
            self.priceLabel.text = "＄\(orders[0].orderPrice+5)"
        }else{
            self.priceLabel.text = "＄\(orders[0].orderPrice)"
        }
    }    
    @IBAction func bubbleSwitch(_ sender: UISwitch) {
        
        if bubbleSwitch.isOn{
            priceLabel.text = "$\(orders[0].orderPrice+5)"
        }else{
            priceLabel.text = "＄\(orders[0].orderPrice)"
        }
    
    }
    
    
}
