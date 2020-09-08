//
//  showTableViewController.swift
//  drink
//
//  Created by fun on 2020/8/22.
//

import UIKit

class showTableViewController: UITableViewController, UISearchResultsUpdating,UISearchBarDelegate{

    
    let searchResultsController = UITableViewController()
    var searchController:UISearchController?
    var ListArray = [List]()
    var OrderList:[List]=[]
    var downloadData:[Download] = []
    var downloadsugue = [Download]()
    //prepare傳資料的變數
    var isShowSearchResult: Bool = false
    var filteredOrderDetails = [Download]()


   
    //使用者輸入要查詢的
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            return
        }
        filterDataSource()
}
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
            print(searchBar.text)
        }
    
    func filterDataSource() {
        filteredOrderDetails = downloadsugue.filter({ (Download) -> Bool in
            return Download.name.lowercased().range(of: searchController!.searchBar.text!.lowercased()) != nil
            print(filteredOrderDetails)

        })

        if filteredOrderDetails.count > 0 {
            print("過濾結果>0")
            
            isShowSearchResult = true
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.init(rawValue: 1)! // 顯示TableView的格線
        } else {
            print("過濾結果=0")
            tableView.separatorStyle = UITableViewCell.SeparatorStyle.none // 移除TableView的格線
            
        }
       tableView.reloadData()
    }

    



    override func viewDidLoad() {
        super.viewDidLoad()
        
        //建立搜尋列但還沒有搜尋的功能
        searchController = UISearchController(searchResultsController: searchResultsController)
        
        tableView.tableHeaderView = searchController?.searchBar
        
        //實作有搜尋功能
        searchController?.searchResultsUpdater = self
        searchController?.searchBar.delegate = self

        
        //開始下拉更新的功能
        self.refreshControl?.addTarget(self, action: #selector(self.handleRefresh(refreshControl:)), for: UIControl.Event.valueChanged)

    }
    @objc func handleRefresh(refreshControl:UIRefreshControl){
    self.download()
    self.tableView.reloadData()
    refreshControl.endRefreshing()
    }
    
    
    
        override func viewDidAppear(_ animated: Bool) {
            download()
        self.tableView.reloadData()

        }
 
    
                            
    
    func showAlert(title:String,msg:String,handler:((UIAlertAction)->Void)?) {
        let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        controller.addAction(okAction)
    present(controller, animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
  
    
    


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    

    // MARK: - Table view data source
    //設定section跟row,row就是有幾杯飲料就有幾個
    
    //因為Static Cells由 Storyboard來控制Cell的數量，不需從程式控制，如不註解，則會因為回傳0，則無法顯示商品列表，變成一片空白。
    override func numberOfSections(in tableView: UITableView) -> Int {
         //#warning Incomplete implementation, return the number of sections
        return 1}
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isShowSearchResult {
            return filteredOrderDetails.count
                } else {
                    return downloadData.count+1
                    //因有多設一個section來算總杯數＆總價格
                }
        
   
        
    }

    //每個 cell 要顯示的內容
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if downloadData.count - indexPath.row != 0 {
            //如果飲料杯數－row代表有幾行（indexpath包含兩個信息參數第幾區section、第幾行row）不等於0[表示已經有飲料訂單]
            let information = downloadData[indexPath.row]
            //設一常數代表飲料共有幾杯（row共有幾行）
            print(information)
             let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath) as! showTableViewCell
                        
            if isShowSearchResult{
                cell.configCell(with: filteredOrderDetails, for: cell, at: indexPath.row)
                print(filteredOrderDetails)
            }else{
                cell.configureCell(data: information)
            
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "totalCell", for: indexPath) as! SumTableViewCell
            //同時讓cell轉型並讀取到“totalCell”的內容
            if downloadData.count != 0 {
                //若有飲料杯數
                print(downloadData.count)
                var total = 0
                //設一變數total來算總和
                for downloadData in downloadData{
                    total += Int(downloadData.price)!
                    //因為取下來的值是String所以要轉乘Int()!才能做加減
                    print(total)
                }//寫訂單的迴圈，讓飲料總價格自動相加
                cell.sumPrice.isHidden = false
                cell.sumPrice.text = "總金額＄\(total)元"
                cell.sumCups.text = "總杯數\(downloadData.count)杯"
            }else{
                cell.sumPrice.isHidden = true
                cell.sumCups.text = "目前沒有訂單"
            }
            return cell
        }
       
    }
    

    
   
    
    //用didSelectRowAt indexPath選到Row去修改cell資料
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showeditdata", sender: indexPath)
        //將飲料訂單cell裡的資料存到下一頁的訂購飲料頁面

    }
 
        
    
    
    func download(){
        if let url = URL(string: UrlRequest.shared.baseUrlString){
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    let decoder = JSONDecoder()
                    self.downloadData.removeAll()
                    if let data = data{
                        do {
                            let drinkData = try decoder.decode([Download].self, from: data)
                                for i in 0...drinkData.count - 1 {
                                    let date = drinkData[i].date
                                    let name = drinkData[i].name
                                    let drink = drinkData[i].drink
                                    let size = drinkData[i].size
                                    let price = drinkData[i].price
                                    let sugar = drinkData[i].sugar
                                    let ice = drinkData[i].ice
                                    let oneOrder = Download(date: date, name: name, drink: drink, size: size, price: price, sugar: sugar, ice: ice)
                                    self.downloadData.append(oneOrder)
                                  
                                }

                        }
                        catch{
                            print(error)
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                                    }
                task.resume()
            }
            
            
            
            
        }
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let order = downloadData[indexPath.row]
        
        let controller = UIAlertController(title: "\(order.name):\(order.drink)", message: "確定要刪除這筆訂單嗎？", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "ok", style: .default) { (_) in
            
            self.deleteOrderDetail(name:order.name){ (_) in
                print("\(order.name):\(order.drink)")
                DispatchQueue.main.async{
                    tableView.reloadData()
                }

                
            }
            
                            self.downloadData.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            let cancelAction = UIAlertAction(title: "cancel", style: .default, handler: nil)
            
        controller.addAction(okAction)
        controller.addAction(cancelAction)
            present(controller, animated: true, completion: nil)
       
        
        }
    
    //刪除上傳的資料
    func deleteOrderDetail(name: String, completionHandler: @escaping(String) -> Void) {
        
        let deleteUrlString = "\(UrlRequest.shared.baseUrlString)/name/\(name)"
               //在api後面加上欄位跟值
               if let urlString = deleteUrlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),let url = URL(string: urlString) {
                   var request = URLRequest(url: url)
                //設定HTTP方法為deleted
                   request.httpMethod = "DELETE"
                   request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    let task = URLSession.shared.dataTask(with: request) { (returnData, response, error) in
                        let decoder = JSONDecoder()
                        if let returnData = returnData, let dictionary = try? decoder.decode([String: Int].self, from: returnData), dictionary["deleted"] == 1{
                                         print("Delete successfully")
                                         completionHandler("刪除成功")
                                     }else{
                                         print("Delete failed")
                                         completionHandler("刪除失敗")
                                     }
                                 
                    }
                task.resume()
                

                }
                
                                    
                                }
    
    
    
    
    

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
        if let controller = segue.destination as?  EditDataTableViewController,let row = tableView.indexPathForSelectedRow?.row{
            let download = downloadData[row]
            controller.editorder = download
            //將飲料訂單cell裡的資料存到下一頁的訂購飲料頁面
            
        }
        
        
        
    }


}
