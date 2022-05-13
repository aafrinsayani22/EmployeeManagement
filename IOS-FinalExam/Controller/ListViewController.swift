import UIKit



class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewRefresh {

    func refresh(){
        tableView.reloadData()
    }

    var loggedUserName : String = ""
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var selectedRow : Int = 0
    
    @IBOutlet weak var lblLoggedUserName : UILabel!

    @IBOutlet weak var tableView : UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblLoggedUserName.text = loggedUserName

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
    }

    @IBAction func btnAdd(_ sender: Any) {
        performSegue(withIdentifier: Source.toInfoViewAdding, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Employee.all(context: self.context).count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let employee = Employee.all(context: self.context)[indexPath.row]
        // to present employee name
        cell.textLabel!.text = employee.name
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedRow = indexPath.row
        
        tableView.deselectRow(at: indexPath, animated: false)
        
        performSegue(withIdentifier: Source.toInfoViewEditing, sender: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        /*
         Here you have to send the selected object to InfoViewController.
         
         
         You can get this object by using the self.selectedRow assigned by tabeView didSelectRowAt function.
         
         Remember to prepare the InfoViewController to receive this object.
         */
        if segue.identifier == Source.toInfoViewAdding {
         

            let employeeInfo = (segue.destination as! InfoViewController)
            
          
            employeeInfo.delegate = self

            employeeInfo.editMode = false


        }
        if segue.identifier == Source.toInfoViewEditing {
            /// Update/delete operations
            
            let employeeInfo = (segue.destination as! InfoViewController)
            employeeInfo.selectedEmployee =  Employee.all(context: self.context)[self.selectedRow]
            employeeInfo.delegate = self
            employeeInfo.editMode = true
          
        
        }
        
    }

    
    @IBAction func btnRefreshTouchUp(_ sender : Any?) {
        
        tableView.reloadData()
        
    }
    
    
}
