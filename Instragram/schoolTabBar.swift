//
//

import UIKit
import Parse
var approved = false
class schoolTabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let user = PFUser.current()!
        
        approved = ((user.value(forKey: "approved"))) as! Bool
        if !approved {
            if let items = tabBar.items  {
                if items.count > 0 {
                    var itemToDisable = items[items.count - 1]
                    itemToDisable.isEnabled = false
                    itemToDisable = items[items.count - 2]
                    itemToDisable.isEnabled = false
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
