//
//  SchoolLists.swift
//  PS Give
//
//  Created by Isha Chirimar on 8/12/17.


import UIKit
import Parse
class SchoolLists: UITableViewController {
    
    var listnames = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        //add pull to refresh later
        
        loadLists()
        
        
       // tableview.dequeueReusableCell(withIdentifier: query.o)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //returns number of cells necessary
  
    func loadLists(){
        
        let query:PFQuery = PFQuery(className: "Wishlists")
        query.whereKey("School", equalTo: PFUser.current()!.username!)
        var gblObjects: [PFObject]?
        
        do {
            try gblObjects = query.findObjects()
        } catch {
            print("Query failed")
        } //catch
        
        if (gblObjects != nil){
            print("Successfully retrieved \(gblObjects!.count) posts.")
            for object in gblObjects!{
                listnames.append(object.object(forKey: "Listname") as! String)
                //print(listnames)
                
                
            } //for loop
           
        } //if
        
    } //loadposts

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listnames.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //print(listnames)
        // define cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WishlistCell
        cell.listbtn.setTitle(listnames[indexPath.row], for: UIControlState())
        //print(listnames[indexPath.row])
  
        // assign index
        cell.listbtn.layer.setValue(indexPath, forKey: "index")
        return cell
    }

    

}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

