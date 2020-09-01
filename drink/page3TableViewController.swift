//
//  page3TableViewController.swift
//  drink
//
//  Created by fun on 2020/8/19.
//

import UIKit

class page3TableViewController: UITableViewController {
    
    var drinks = [Drink]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let urlStr = "https://sheetdb.io/api/v1/zpsna7suu2sdv".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ,
           let url = URL(string: urlStr) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
               
                
                if let data = data{
                                do{
                                    let DrinkData = try decoder.decode([Drink].self, from: data)
                                    print(DrinkData)
                                    self.drinks = DrinkData
                                    
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()

                                    }

                                }catch{
                                    print(error)
                                }
                }
                         }.resume()
                        }
                    
            

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinks.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "page3Cell", for: indexPath) as! page3TableViewCell
        
        let Drink = drinks[indexPath.row]
        
        cell.page3Name.text = Drink.name
        cell.page3Price.text = Drink.price
        cell.page3City.text = Drink.city
        cell.page3Ice.text = Drink.recommendIce
        cell.page3Sugar.text = Drink.recommendSugar
        cell.page3Detail.text = Drink.detail

        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
