

import UIKit
import Parse
var image3: UIImage? = nil
var imgpicked: Bool = false
var certpicked: Bool = false
class schoolSignUpVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    
    
    
    // profile image
    @IBOutlet weak var avaImg: UIImageView!
    
    
    // textfields
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var fullnameTxt: UITextField!
    @IBOutlet weak var webTxt: UITextField!
    @IBOutlet weak var certificatePicker: UIButton!
    
    // buttons
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    // scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    // reset default size
    var scrollViewHeight : CGFloat = 0
    
    // keyboard frame size
    var keyboard = CGRect()
    
    
    // default func
    override func viewDidLoad() {
        super.viewDidLoad()
        //Button styling
        signUpBtn.layer.cornerRadius = 5
        cancelBtn.layer.cornerRadius = 5
        signUpBtn.layer.borderWidth = 1
        cancelBtn.layer.borderWidth = 1
        signUpBtn.layer.borderColor = UIColor.lightGray.cgColor
        cancelBtn.layer.borderColor = UIColor.lightGray.cgColor

        
        // scrollview frame size
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        scrollView.contentSize.height = self.view.frame.height
        scrollViewHeight = scrollView.frame.size.height
        
        // check notifications if keyboard is shown or not
        NotificationCenter.default.addObserver(self, selector: #selector(donorSignUpVC.showKeyboard(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(donorSignUpVC.hideKeybard(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // declare hide kyboard tap
        let hideTap = UITapGestureRecognizer(target: self, action: #selector(donorSignUpVC.hideKeyboardTap(_:)))
        hideTap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hideTap)
        
        
        
        // declare select image tap
        let avaTap = UITapGestureRecognizer(target: self, action: #selector(donorSignUpVC.loadImg(_:)))
        avaTap.numberOfTapsRequired = 1
        avaImg.isUserInteractionEnabled = true
        avaImg.addGestureRecognizer(avaTap)
        
        
        
        
    }
    //image picker for certificate
    @IBAction func certButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    

    
    // call picker to select ava image
    func loadImg(_ recognizer:UITapGestureRecognizer) {
        let picker2 = UIImagePickerController()
        picker2.delegate = self
        picker2.sourceType = .photoLibrary
        picker2.allowsEditing = true
        present(picker2, animated: true, completion: nil)
        imgpicked = true
    }
    
    
    
    // connect selected image to our ImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if imgpicked{
        var avaimage: UIImage? = info[UIImagePickerControllerEditedImage] as! UIImage?
        avaImg.image = avaimage! as! UIImage
        self.dismiss(animated: true, completion: nil)
        imgpicked = false
        } else {
             image3 = info[UIImagePickerControllerEditedImage] as? UIImage
            self.dismiss(animated: true, completion: nil)
            certpicked = true
        }
    }
    
    
    // hide keyboard if tapped
    func hideKeyboardTap(_ recoginizer:UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    
    // show keyboard
    func showKeyboard(_ notification:Notification) {
        
        // define keyboard size
        keyboard = ((notification.userInfo?[UIKeyboardFrameEndUserInfoKey]! as AnyObject).cgRectValue)!
        
        // move up UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrollView.frame.size.height = self.scrollViewHeight - self.keyboard.height
        })
    }
    
    
    // hide keyboard func
    func hideKeybard(_ notification:Notification) {
        
        // move down UI
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.scrollView.frame.size.height = self.view.frame.height
        })
    }
    

    
    
    // clicked sign up
    @IBAction func signUpBtn_click(_ sender: AnyObject) {
        if DEBUG { print("Sign Up as new user pressed")}
        
        if false {
            print("Starting query")
            let query:PFQuery = PFQuery(className: "User")
            query.whereKey("username", equalTo: "ishachirimar2")
            var gblObjects: [PFObject]?
            
            do {
                try gblObjects = query.findObjects()
            } catch {
                print("Query failed")
            }
            
            if (gblObjects != nil){
                print("Successfully retrieved \(gblObjects!.count) users.")
                for object in gblObjects!{
                    print( object.object(forKey: "email"))
                }
            }
            
            print("After query")
        }
        
        // dismiss keyboard
        self.view.endEditing(true)
        
        if(DEBUG){
            print("DEBUG username: " + usernameTxt.text!)
            print("DEBUG passwd: " + passwordTxt.text!)
            print("DEBUG email: " + emailTxt.text!)
            print("DEBUG full name: " + fullnameTxt.text!)
            print("DEBUG certpicked \(certpicked)")
            
        }
        
        if (usernameTxt.text!.isEmpty || passwordTxt.text!.isEmpty || repeatPassword.text!.isEmpty || emailTxt.text!.isEmpty || fullnameTxt.text!.isEmpty || certpicked == false) {
            
            // alert message
            let alert = UIAlertController(title: "PLEASE", message: "fill all fields", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        // if different passwords
        if passwordTxt.text != repeatPassword.text {
            
            // alert message
            let alert = UIAlertController(title: "PASSWORDS", message: "do not match", preferredStyle: UIAlertControllerStyle.alert)
            let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        //if username exists in database then ask for new user
        let query = PFQuery(className: "User")
        query.whereKey("username", equalTo: usernameTxt.text! as String)
        query.findObjectsInBackground(block:{
            (objects:[PFObject]?, error:Error?)-> Void in
            if error == nil {
                if (objects!.count > 0){
                    if DEBUG {print("DEBUG: user taken")}
                    let alert = UIAlertController(title: "USERNAME", message: self.usernameTxt.text! + " is taken. Try a new name", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if DEBUG {print ("DEBUG: user availble")}
                }
            } else {
                print(error)
                let alert = UIAlertController(title: "ERROR", message: "Unexpected error", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        
        //if email exists in database then ask for new info
        let query2:PFQuery = PFQuery(className: "User")
        query2.whereKey("email", equalTo: emailTxt.text!)
        query2.findObjectsInBackground(block: {
            (objects:[PFObject]?, error:Error?)-> Void in
            if error == nil {
                if (objects!.count > 0){
                    if DEBUG {print("DEBUG: email taken")}
                    let alert = UIAlertController(title: "EMAIL", message: self.emailTxt.text! + " is taken. Please use a new email", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    if DEBUG {print ("DEBUG: email is not in used")}
                }
            } else {
                print(error)
                let alert = UIAlertController(title: "ERROR", message: "Unexpected error", preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        
        // send data to server to related columns
        let user = PFUser()
        user.username = usernameTxt.text?.lowercased()
        user.email = emailTxt.text?.lowercased()
        
        
        
        user.password = passwordTxt.text
        user["fullname"] = fullnameTxt.text
        user["web"] = webTxt.text
        user["type"] = "school"
        
        // in Edit Profile it's gonna be assigned
        user["tel"] = ""
        user["gender"] = ""
        //status
        user["approved"] = false
        
        // convert our image for sending to server
        let avaData = UIImageJPEGRepresentation(avaImg.image!, 0.5)
        let fileName = user.username! + user.password!
        let avaFile = PFFile(name: fileName, data: avaData!)
        user["ava"] = avaFile
        
        let cert = UIImageJPEGRepresentation(image3!, 0.5)
        let name = user["username"] as? String
        let certFile = PFFile(name: name, data: cert!)
        user["certificate"] = certFile
        // save data in server
        user.signUpInBackground { (success, error) -> Void in
            if success {
                
                print("registered")
                
                
                
                // remember logged user
                UserDefaults.standard.set(user.username, forKey: "username")
                UserDefaults.standard.synchronize()
                
                // call login func from AppDelegate.swift class
                let appDelegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.login()
                /*
                guard let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier : "SchoolTabBar") as? schoolTabBar
                    else {
                        print("Could not instantiate view controller with identifier of type schoolTabBar")
                        
                        return
                }
                
                self.present(vc, animated:true)
 */
                
            } else {
                
                
                // show alert message
                let alert = UIAlertController(title: "Error", message: error!.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
                
            }
            
        }
        
        
    }
    
    
    // clicked cancel
    @IBAction func cancelBtn_click(_ sender: AnyObject) {
        
        
        // hide keyboard when pressed cancel
        self.view.endEditing(true)
        
      
    }
    
    
    
    
}
