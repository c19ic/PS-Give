//
//  ViewList.swift
//  PS Give
//
//  Created by Isha Chirimar on 8/16/17.
//
//

import UIKit
import Parse

class ViewList: UITableViewController {
    //var items = [String]()
    //  HARDCODE:
    //TODO:
        // add in the code for pulling items. this should i
    var items = ["Black Trash Bags", "Ticonderoga Pencils 12 Pack"]
    var prices = ["5.50", "3.99"]
    override func viewDidLoad() {
        super.viewDidLoad()

      
        loadItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //fix this
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //this is not hardcoded
        return items.count
    }
    
    func loadItems(){
        //PFQuery takes strings of items in list on database
        
        let query = PFQuery(className: "Wishlists")
        query.whereKeyExists(key)
        var gblObjects: [PFObject]?
        do {
            try gblObjects = query.findObjects()
        } catch {
            print("Query Failed")
        }
        if(gblObjects != nil){
            for object in gblObjects!{
                self.items.append(object.object(forKey: "List") as! String)
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ItemCell
        
        cell.productName.text = items[indexPath.row] as! String
        cell.productPrice.text = "$ \(prices[indexPath.row] as! String)"

        // Configure the cell...

        return cell
    }
    @IBAction func addtocart(_ sender: Any) {
       let alert = UIAlertController(title: "Item Added", message: "You're one step closer to helping the public education system!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
