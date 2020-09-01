//
//  showTableViewController.swift
//  drink
//
//  Created by fun on 2020/8/22.
//

import UIKit

class showTableViewController: UITableViewController {
    
    var ListArray = [List]()
    var OrderList:[List]=[]
    
    @IBAction func unwindToShow(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? editTableViewController,
           let orderOneDrink = sourceViewController.orderList{
            
            if let indexPath = tableView.indexPathForSelectedRow{
                
                OrderList[indexPath.row] = orderOneDrink
                tableView.reloadRows(at: [indexPath], with: .automatic)}
            else{
                    OrderList.insert(orderOneDrink, at: 0)
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with:.automatic )
          
            
        }
        // Use data from the view controller which initiated the unwind segue
        }
    }



    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
        override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
            getOrderList()

        }
    
    
    
    
    
    
    //取得sheetDB訂單資料
    func getOrderList(){
                let urlStr = "https://sheetdb.io/api/v1/u2r459ric9akb".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                // 將網址轉換成URL編碼（Percent-Encoding）
                let url = URL(string: urlStr!) // 將字串轉換成url
                
                // 背景抓取飲料訂單資料
                let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                    if let data = data, let content = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [[String: Any]]{
                        // 因為資料的Json的格式為陣列（Array）包物件（Object），所以[[String: Any]]
                        
                        for order in content {
                            if let data = List(json: order){
                                self.ListArray.append(data)
                            }
                        }

                        
                        // 更新TableView，UI的更新必須在Main thread
                        DispatchQueue.main.async {
                            
                            self.tableView.reloadData() // 更新訂購表
                           
                        }
                    }
                }
                task.resume() // 開始在背景下載資料
    }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source
    //設定section跟row,row就是有幾杯飲料就有幾個
    
    //numberOfSections可用來限制使用數量故可省略因飲料杯數會一直增加
    //override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //return 0}
    //每一組有幾個 cell
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return ListArray.count+1
        //因有多設一個section來算總杯數＆總價格
    }

    //每個 cell 要顯示的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if ListArray.count - indexPath.row != 0{
            //如果飲料杯數－row代表有幾行（indexpath包含兩個信息參數第幾區section、第幾行row）不等於0[表示已經有飲料訂單]
            let information = ListArray[indexPath.row]
            //設一常數代表飲料共有幾杯（row共有幾行）
             let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! showTableViewCell
            //讓cell轉型並讀取到“showCell”的內容
            DispatchQueue.main.async {
                cell.orderName.text = information.name
                cell.orderDrink.text = information.drink
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! SumTableViewCell
            //同時讓cell轉型並讀取到“totalCell”的內容
            if ListArray.count != 0{
                //若有飲料杯數
                var total = 0
                //設一變數total來算總和
                for ListArray in ListArray{
                   total = total + ListArray.price
                }//寫訂單的迴圈，讓飲料總價格自動相加
                cell.sumPrice.isHidden = false
                cell.sumPrice.text = "總金額＄\(total)元"
                cell.sumCups.text = "總杯數\(ListArray.count)杯"
            }else{
                cell.sumPrice.isHidden = true
                cell.sumCups.text = "目前沒有訂單"
            }
            return cell
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showedit", sender: indexPath)
    }

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
    //override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   //     if let controller = segue.destination as?  editTableViewController,let row = tableView.indexPathForSelectedRow?.row{
    //        controller.orderList = OrderList[row]}}
    


}
