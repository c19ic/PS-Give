

import UIKit
import Parse
var url:String = ""
var key: String = ""

class feedVC: UITableViewController {
    
    
    
    // UI objects
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    var refresher = UIRefreshControl()
    
    
    
    // arrays to hold server data
    //var usernameArray = [String]()
    var avaArray = [PFFile]()
    var dateArray = [Date?]()
    var picArray = [PFFile]()
    var titleArray = [String]()
    var uuidArray = [String]()
    var donateArray = [String]()
    var schoolArray = [String]()
    var descripArray = [String]()
    // page size
    var page : Int = 10
    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // title at the top
        self.navigationItem.title = "WISHLISTS"
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Nunito-Regular", size: 20)!]
        // automatic row height - dynamic cell
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 450
        
        // receive notification from uploadVC
        NotificationCenter.default.addObserver(self, selector: #selector(feedVC.uploaded(_:)), name: NSNotification.Name(rawValue: "uploaded"), object: nil)
        
        // calling function to load posts
        loadPosts()
        
    } //viewdidload
    
    
    
    
    
    // reloading func with posts  after received notification
    func uploaded(_ notification:Notification) {
        loadPosts()
    } //uploaded
    
    
    // load posts
    func loadPosts() {
        
        
        
        print("Starting query")
        let query:PFQuery = PFQuery(className: "Wishlists")
        var gblObjects: [PFObject]?
        
        do {
            try gblObjects = query.findObjects() //JCFIX- use in background version like other places
        } catch {
            print("Query failed")
        } //catch
        
        if (gblObjects != nil){
            print("Successfully retrieved \(gblObjects!.count) posts.")
            for object in gblObjects!{
                self.schoolArray.append(object.object(forKey: "School") as! String)
                //self.avaArray.append(object.object(forKey: "Image") as! PFFile)
                self.titleArray.append(object.object(forKey: "Listname") as! String)
                self.uuidArray.append(object.object(forKey: "uuid") as! String)
                self.descripArray.append(object.object(forKey: "description") as! String)
                
                //  self.donateArray.append(object.object(forKey: "link") as! String)
            } //for loop
            
            
        } //if loop
        
    } //loadposts
    
//scrolled down
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= scrollView.contentSize.height - self.view.frame.size.height * 2 {
            loadMore()
        }
    }  //scrollviewdidscroll
    
    
    
    // pagination
    func loadMore() {
        
        // if posts on the server are more than shown
        if page <= uuidArray.count {
            
            // increase page size to load +10 posts
            page = page + 10
            
            
            //  Find posts made by people appended to schoolArray
            let query = PFQuery(className: "Wishlists")
            query.limit = self.page
            query.addDescendingOrder("createdAt")
            query.findObjectsInBackground(block: { (objects, error) -> Void in
                if error == nil {
                    
                    // clean up
                    self.schoolArray.removeAll(keepingCapacity: false)
                    self.avaArray.removeAll(keepingCapacity: false)
                    self.titleArray.removeAll(keepingCapacity: false)
                    self.uuidArray.removeAll(keepingCapacity: false)
                    //self.donateArray.removeAll(keepingCapacity: false)
                    // find related objects
                    for object in objects! {
                        self.schoolArray.append(object.object(forKey: "School") as! String)
                        //self.avaArray.append(object.object(forKey: "ava") as! PFFile)
                        //self.dateArray.append(object.createdAt)
                        //self.picArray.append(object.object(forKey: "pic") as! PFFile)
                        self.uuidArray.append(object.object(forKey: "uuid") as! String)
                        
                    } //for
                    
                    
                } //if
                else {
                    print(error!.localizedDescription)
                }
            }) //query
        }//if
    } //loadmore
    
    // cell numb
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return uuidArray.count
    }
    
    
    // cell config
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.school_name.setTitle(schoolArray[indexPath.row] as! String?, for: UIControlState.normal)
        cell.list_name.text = titleArray[indexPath.row] as! String
        cell.list_descrip.text = descripArray[indexPath.row] as! String
        cell.uuid.text = uuidArray[indexPath.row] as! String
        //cell.view_list.setTitle(titleArray[indexPath.row] as! String?, for: UIControlState.normal)
        return cell
    }
    
 
    

    //tableview func
    
    
    // alert action
    func alert (_ title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    } //closes alert
} //closes class
