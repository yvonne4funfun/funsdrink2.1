//
//  editTableViewController.swift
//  drink
//
//  Created by fun on 2020/8/22.
//

import UIKit

class EditTableViewController: UITableViewController {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bubbleSwitch: UISwitch!
    @IBOutlet weak var size: UISegmentedControl!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var sugar: UISegmentedControl!
    @IBOutlet weak var drinkButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
 
    var orders:[Order]=[]
    var drinks:[Drink]=[]
    var downloadeditdata:[Download] = []
    var orderList:List!
    var download:Download!
    var teaorder = TeaChoicesData()


    
    var selectedDrink:Order!
    //此變數設定選到的飲料跟價格

    
    //更新飲料選到第幾杯跟價錢
    func updateUI(with selectedDrink:Order) {
        DispatchQueue.main.async { [self] in
            drinkButton.setTitle(selectedDrink.orderDrink, for: .normal)
            priceLabel.text = "\(selectedDrink.orderPrice)"
        }
    }
    


    
 
    
    override func viewDidLoad(){
        super.viewDidLoad()
        dowmLoadMenu()

        if let download  = download {
            //設定show頁面傳到edit頁面的資料，sigment、switch需轉型
            nameTextField.text = download.name
            drinkButton.setTitle("\(download.drink)", for: .normal)
            drinkButton.setTitleColor(UIColor.black, for: .normal)
            priceLabel.text = download.price
            size.selectedSegmentIndex = convertStringToIndex(str: download.size)
            sugar.selectedSegmentIndex = convertStringToIndex(str: download.sugar)
            ice.selectedSegmentIndex = convertStringToIndex(str: download.ice)

        }
        
            
    }
    //如果換飲料就更新容量為中杯
    func updateSizeSegmentedControl(){
          size.selectedSegmentIndex = 0
    }
    
  
    
    func convertStringToIndex(str: String) -> Int {
    switch str {
    case "全糖","中杯", "正常":
    return 0
    case  "少糖","大杯", "少冰":
    return 1
    case "半糖", "微冰":
    return 2
    case "微糖","去冰" :
    return 3
    case "無糖","熱飲" :
    return 4
    default:
        return 0
    }
    }
    
    
    func segment(){
        if size.selectedSegmentIndex == 0 {
        teaorder.size = "中杯"
        }else {
        teaorder.size = "大杯"
        }
        print("容量：\(teaorder.size)")
        //甜度資料
        switch sugar.selectedSegmentIndex {
        case 0:
        teaorder.sugar = .regular
        case 1:
        teaorder.sugar = .lessSuger
        case 2:
        teaorder.sugar = .halfSuger
        case 3:
        teaorder.sugar = .quarterSuger
        case 4:
        teaorder.sugar = .sugerFree
        default:
        break
        }
        print("甜度：\(teaorder.sugar.rawValue)")
        //冰度資料
        switch ice.selectedSegmentIndex {
        case 0:
        teaorder.ice = .regular
        case 1:
        teaorder.ice = .moreIce
        case 2:
        teaorder.ice = .easyIce
        case 3:
        teaorder.ice = .iceFree
        case 4:
            teaorder.ice = .hot

        default:
        break
        }
        print("冰度：\(teaorder.ice.rawValue)")
        
    
        

    }
    
    
 
   
    func dowmLoadMenu(){
        //下載菜單的資訊
         if let url = URL(string:"https://sheetdb.io/api/v1/h9wymzqlaytix") {
            let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
                        let decoder = JSONDecoder()
                        if let data = data {
                            do{
                            let drinkData = try decoder.decode([Drink].self, from: data)
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
                                //下載完菜單後，把預設的第一個order指定給selectedDrink，就可以拿到名稱跟價格
                                selectedDrink = orders[0]
                                
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showeditdata"{
            let editorder = downloadeditdata[tableView.indexPathForSelectedRow!.row]
            let editTableView = segue.destination as! EditDataTableViewController
            editTableView.editorder  = editorder
        }
    }
        
    
    
    @IBAction func drinkButton(_ sender: UIButton) {
        
        updateSizeSegmentedControl()

        
        //控制容量限制
        let name = ["錫金紅茶","夢幻紅茶","珍珠那提","抹茶那提","煮濃那提","生乳紅茶","糖檸紅茶","玉釀紅茶","冰淇淋紅茶"]
        //控制"僅去冰"限制
        let iceFree = ["錫金紅茶","夢幻紅茶"]
        //控制“僅少冰”
        let easyIce = ["煮濃那提","生乳紅茶","生乳抹茶"]
        //控制“僅微糖”
        let quarterSugar = "玉釀紅茶"
        //控制"僅無糖"限制
        let sugarFree = ["錫金紅茶","夢幻紅茶"]
        

        let controller = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        for drink in orders {
            let action = UIAlertAction(title: drink.orderDrink, style: .default) { [self] (_) in
            sender.setTitleColor(UIColor.black, for: .normal)
                selectedDrink = drink
                sender.setTitle(selectedDrink.orderDrink, for: .normal)
                self.priceLabel.text = "\(selectedDrink.orderPrice)"
                //點選飲料priceLabel顯示對印的價格

                
                if name.contains(drink.orderDrink) {
                    self.size.setEnabled(false, forSegmentAt: 1)
                    self.priceLabel.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.size.setEnabled(true, forSegmentAt: 1)
                }//若選到這些飲料只有中杯，大杯的segment選項會失效
                
                if easyIce.contains(drink.orderDrink) {
                    self.ice.setEnabled(false, forSegmentAt: 0)
                    self.ice.setEnabled(false, forSegmentAt: 2)
                    self.ice.setEnabled(false, forSegmentAt: 3)
                    self.ice.setEnabled(false, forSegmentAt: 4)
                    self.priceLabel.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.ice.setEnabled(true, forSegmentAt: 0)
                    self.ice.setEnabled(true, forSegmentAt: 2)
                    self.ice.setEnabled(true, forSegmentAt: 3)
                    self.ice.setEnabled(true, forSegmentAt: 4)
                }//若選到這些飲料只有少冰，其他的segment選項會失效
                
                
                if iceFree.contains(drink.orderDrink) {
                    self.ice.setEnabled(false, forSegmentAt: 0)
                    self.ice.setEnabled(false, forSegmentAt: 2)
                    self.ice.setEnabled(false, forSegmentAt: 1)
                    self.ice.setEnabled(false, forSegmentAt: 4)
                    self.priceLabel.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.ice.setEnabled(true, forSegmentAt: 0)
                    self.ice.setEnabled(true, forSegmentAt: 2)
                    self.ice.setEnabled(true, forSegmentAt: 1)
                    self.ice.setEnabled(true, forSegmentAt: 4)
                }//若選到這些飲料只有去冰，其他的segment選項會失效
                
                
                if quarterSugar.contains(drink.orderDrink) {
                    self.sugar.setEnabled(false, forSegmentAt: 0)
                    self.sugar.setEnabled(false, forSegmentAt: 2)
                    self.sugar.setEnabled(false, forSegmentAt: 1)
                    self.sugar.setEnabled(false, forSegmentAt: 4)
                    self.priceLabel.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.sugar.setEnabled(true, forSegmentAt: 0)
                    self.sugar.setEnabled(true, forSegmentAt: 2)
                    self.sugar.setEnabled(true, forSegmentAt: 1)
                    self.sugar.setEnabled(true, forSegmentAt: 4)
                }//若選到這些飲料只有微糖，其他的segment選項會失效
                
                
                if sugarFree.contains(drink.orderDrink) {
                    self.sugar.setEnabled(false, forSegmentAt: 0)
                    self.sugar.setEnabled(false, forSegmentAt: 2)
                    self.sugar.setEnabled(false, forSegmentAt: 3)
                    self.sugar.setEnabled(false, forSegmentAt: 1)
                    self.priceLabel.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.sugar.setEnabled(true, forSegmentAt: 0)
                    self.sugar.setEnabled(true, forSegmentAt: 2)
                    self.sugar.setEnabled(true, forSegmentAt: 3)
                    self.sugar.setEnabled(true, forSegmentAt: 1)
                    
                }//若選到這些飲料只有無糖，其他的segment選項會失效

            }
            controller.addAction(action)


            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        

        
        
    }
        

        
        

    
    
    @IBAction func sentButton(_ sender: UIButton) {
        showAlert()
        keepData()
    }
    
    
    func showAlert(){
        if nameTextField.text?.isEmpty == true {
            let controller = UIAlertController(title: "請填入名字", message: nil, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
            return
        }else{
            if  drinkButton.titleColor(for: .normal) == UIColor.black{
                //利用選項的顏色判斷有沒有選到
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
        
        func post(orderData:List){
            //上傳資料對應的data
            let url = URL(string: "https://sheetdb.io/api/v1/e5wq4fvw0u56q")
            //設定上傳資料的網址
            var urlRequest = URLRequest(url: url!)
            urlRequest.httpMethod = "POST"
            //上傳所以使用POST
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let order = OrderData(data: orderData)
            //要編碼的資料
            let jsonEncoder = JSONEncoder()
            //使用jsonEncoder將資料編碼上傳
            if let encoderData = try? jsonEncoder.encode(order){
                let task = URLSession.shared.uploadTask(with: urlRequest, from: encoderData) { (retData, res, err) in
                    //(retData, res, err)是會回傳字典告訴結果
                    let decoder = JSONDecoder()
                    //解碼字典
                    if let retData = retData, let dic = try? decoder.decode([String:Int].self, from: retData), dic["created"] == 1 {
                        //[String:Int]=回傳字典的型別 ["created"] == 1，如果有新增成功，”created”的值會是新增的筆數。
                        DispatchQueue.main.async {
                            self.navigationController?.popViewController(animated: true)
                        }
                        print("ok")
                    }else{
                        print("error")
                        
                    }
                }
                task.resume()
            }
                
            }
    
    
    
    
        
    @IBAction func sizeSegmentControl(_ sender: UISegmentedControl) {
        if size.selectedSegmentIndex == 1 {
           selectedDrink.orderPrice += 5
            
            
            
        }else if size.selectedSegmentIndex == 0{
            selectedDrink.orderPrice -= 5

        }
        DispatchQueue.main.async { [self] in
            updateUI(with: selectedDrink)

        }

    }
    
    @IBAction func bubbleSwitch(_ sender: UISwitch) {
        
        if bubbleSwitch.isOn == true{
            selectedDrink.orderPrice += 5
            nameTextField.text! += "（加珍珠）"
            

            
        }else if bubbleSwitch.isOn == false{
            selectedDrink.orderPrice -= 5
            nameTextField.text =  ""

        }
        DispatchQueue.main.async { [self] in
            updateUI(with: selectedDrink)

        }
    }
    
    
    func keepData(){
        //將要上傳的資料存在data裡
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateData = formatter.string(from: time)
        print(dateData)
        //現在的時間
        let nameData = nameTextField.text!
        let order = drinkButton.title(for: .normal)!
        let priceData:Int = selectedDrink.orderPrice
        let sugarData = sugar.titleForSegment(at: sugar.selectedSegmentIndex) ?? ""
        let sizeData = size.titleForSegment(at: size.selectedSegmentIndex) ?? ""
        let icedata = ice.titleForSegment(at: ice.selectedSegmentIndex) ?? ""
        
        
        let newData = List(date: dateData, name: nameData, drink: order, size: sizeData, price: priceData, sugar: sugarData, ice: icedata)
        post(orderData: newData)
        
        
    }

}
