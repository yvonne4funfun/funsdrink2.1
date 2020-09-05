//
//  EditDataTableViewController.swift
//  drink
//
//  Created by fun on 2020/9/3.
//

import UIKit

class EditDataTableViewController: UITableViewController {
    var editorder:Download!
    var teaorder = TeaChoicesData()
    var orders:[Order]=[]
    var selectedDrink:Order!
    var downloadData:[Download] = []



    //此變數設定選到的飲料跟價格

    //設傳資料的變數
    @IBOutlet weak var editSL: UISegmentedControl!
    @IBOutlet weak var editName: UITextField!
    @IBOutlet weak var editDrink: UIButton!
    @IBOutlet weak var editprice: UILabel!
    @IBOutlet weak var editbubble: UISwitch!
    @IBOutlet weak var editice: UISegmentedControl!
    @IBOutlet weak var editsugar: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dowmLoadMenu()

        
        if let editorder = editorder{
            //設定show頁面傳到editdata頁面的資料，sigment、switch需轉型
            editName.text = editorder.name
            editDrink.setTitle("\(editorder.drink)", for: .normal)
            editDrink.setTitleColor(UIColor.black, for: .normal)
            editprice.text = editorder.price
            editSL.selectedSegmentIndex = convertStringToIndex(str: editorder.size)
            editsugar.selectedSegmentIndex = convertStringToIndex(str: editorder.sugar)
            editice.selectedSegmentIndex = convertStringToIndex(str: editorder.ice)
            
        }
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
        if editSL.selectedSegmentIndex == 0 {
        teaorder.size = "中杯"
        }else {
        teaorder.size = "大杯"
        }
        print("容量：\(teaorder.size)")
        //甜度資料
        switch editsugar.selectedSegmentIndex {
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
        switch editice.selectedSegmentIndex {
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
             let task = URLSession.shared.dataTask(with: url) {  (data, response, error) in
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
                                self.selectedDrink = self.orders[0]
                                 
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

    func keepData(){
        let time = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateData = formatter.string(from: time)
        print(dateData)
        //現在的時間
        let nameData = editName.text!
        let order = editDrink.title(for: .normal)!
        let priceData = "\(selectedDrink.orderPrice)"
        let sugarData = editsugar.titleForSegment(at: editsugar.selectedSegmentIndex) ?? ""
        let sizeData = editSL.titleForSegment(at: editSL.selectedSegmentIndex) ?? ""
        let icedata = editice.titleForSegment(at: editice.selectedSegmentIndex) ?? ""
        
        let newData = Download(date: dateData, name: nameData, drink: order, size: sizeData, price: priceData, sugar: sugarData, ice: icedata)
        update(order: newData)
        
        }
    
    func update(order:Download){
        let url = URL(string: "https://sheetdb.io/api/v1/e5wq4fvw0u56q/name/\(order.name)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)//在api後面加上欄位跟值
                var request = URLRequest(url: url!)
                   request.httpMethod = "PUT"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")

                let ordertoupload = UploadToData(data: [order])
                
                let jsonencoder = JSONEncoder()
                if let data = try? jsonencoder.encode(ordertoupload){
                    let task = URLSession.shared.uploadTask(with: request, from: data) { (returnData, response, error) in
                        let decoder = JSONDecoder()
                        if let returnData = returnData,let dictionary = try? decoder.decode([String: Int].self, from: returnData), dictionary["updated"] == 1{
                                         print("updated successfully")
                                     }else{
                                         print("updated failed")
                                     }
                                 }
                    task.resume()
                }
                
                                    
                                }
    
        
    


    @IBAction func editButton(_ sender: Any) {
        keepData()
        let controller = UIAlertController(title: nil, message: "確定修改訂單嗎？", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "cancel", style: .default, handler: nil)
        
        controller.addAction(okAction)
        controller.addAction(cancel)
        present(controller, animated: true, completion: nil)
        
    }
    
    
    @IBAction func drinkButton(_ sender: UIButton) {
        

        
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
                self.editprice.text = "\(selectedDrink.orderPrice)"
                //點選飲料priceLabel顯示對印的價格

                
                if name.contains(drink.orderDrink) {
                    self.editSL.setEnabled(false, forSegmentAt: 1)
                    self.editprice.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.editSL.setEnabled(true, forSegmentAt: 1)
                }//若選到這些飲料只有中杯，大杯的segment選項會失效
                
                if easyIce.contains(drink.orderDrink) {
                    self.editice.setEnabled(false, forSegmentAt: 0)
                    self.editice.setEnabled(false, forSegmentAt: 2)
                    self.editice.setEnabled(false, forSegmentAt: 3)
                    self.editice.setEnabled(false, forSegmentAt: 4)
                    self.editprice.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.editice.setEnabled(true, forSegmentAt: 0)
                    self.editice.setEnabled(true, forSegmentAt: 2)
                    self.editice.setEnabled(true, forSegmentAt: 3)
                    self.editice.setEnabled(true, forSegmentAt: 4)
                }//若選到這些飲料只有少冰，其他的segment選項會失效
                
                
                if iceFree.contains(drink.orderDrink) {
                    self.editice.setEnabled(false, forSegmentAt: 0)
                    self.editice.setEnabled(false, forSegmentAt: 2)
                    self.editice.setEnabled(false, forSegmentAt: 1)
                    self.editice.setEnabled(false, forSegmentAt: 4)
                    self.editprice.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.editice.setEnabled(true, forSegmentAt: 0)
                    self.editice.setEnabled(true, forSegmentAt: 2)
                    self.editice.setEnabled(true, forSegmentAt: 1)
                    self.editice.setEnabled(true, forSegmentAt: 4)
                }//若選到這些飲料只有去冰，其他的segment選項會失效
                
                
                if quarterSugar.contains(drink.orderDrink) {
                    self.editsugar.setEnabled(false, forSegmentAt: 0)
                    self.editsugar.setEnabled(false, forSegmentAt: 2)
                    self.editsugar.setEnabled(false, forSegmentAt: 1)
                    self.editsugar.setEnabled(false, forSegmentAt: 4)
                    self.editprice.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.editsugar.setEnabled(true, forSegmentAt: 0)
                    self.editsugar.setEnabled(true, forSegmentAt: 2)
                    self.editsugar.setEnabled(true, forSegmentAt: 1)
                    self.editsugar.setEnabled(true, forSegmentAt: 4)
                }//若選到這些飲料只有微糖，其他的segment選項會失效
                
                
                if sugarFree.contains(drink.orderDrink) {
                    self.editsugar.setEnabled(false, forSegmentAt: 0)
                    self.editsugar.setEnabled(false, forSegmentAt: 2)
                    self.editsugar.setEnabled(false, forSegmentAt: 3)
                    self.editsugar.setEnabled(false, forSegmentAt: 1)
                    self.editprice.text = "\(selectedDrink.orderPrice)"
                }else{
                    self.editsugar.setEnabled(true, forSegmentAt: 0)
                    self.editsugar.setEnabled(true, forSegmentAt: 2)
                    self.editsugar.setEnabled(true, forSegmentAt: 3)
                    self.editsugar.setEnabled(true, forSegmentAt: 1)
                    
                }//若選到這些飲料只有無糖，其他的segment選項會失效

            }
            controller.addAction(action)


            
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                controller.addAction(cancelAction)
        present(controller, animated: true, completion: nil)
        

        
        
    }
        
        
        
    }
    

