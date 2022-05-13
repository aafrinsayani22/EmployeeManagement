import UIKit

class ViewController: UIViewController {
    
  
    @IBOutlet weak var txtUsername: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    public var username : String! = "2030150"
    public var password : String! = "adm123"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        /*
         You have to implement here the validation for the fields, returning TRUE if everything is good or
         FALSE if the Segue should not be performed.
         */
        if identifier == Source.toListView {
    
                    
            if (txtUsername.text!.isEmpty) {
                
                Toast.ok(view: self, title: "Oops!", message: "Please, Enter your Username", handler: nil)
            
                return false
            }

            if (txtUsername.text! != username )
            {
                Toast.ok(view: self, title: "Ooops!", message: "Incorrect Username!", handler: nil)

                return false
            }
            if (txtPassword.text!.isEmpty) {
                
                Toast.ok(view: self, title: "Oops!", message: "Please, Enter your Passowrd!", handler: nil)
            
                return false
            }
            
            if (txtPassword.text! != password)
            {
                Toast.ok(view: self, title: "Ooops!", message: "Incorrect password!", handler: nil)

                return false
            }
            
            
            return true
        
        }
        
        return false
        
      
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
         Implement the code to send the user name to ListViewController.
         */
        
        if segue.identifier == Source.toListView {
          
            let employeeListViewController = segue.destination as! ListViewController
            employeeListViewController.loggedUserName = txtUsername.text!
        }
        
    }
}

