import UIKit



protocol TableViewRefresh {
    /// Protocol to auto-refresh the list - don't touch this code.
    func refresh()
}

class InfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    public var selectedEmployee : Employee?
    public var editMode : Bool = false
    var delegate : TableViewRefresh?
    
    @IBOutlet weak var btnDeleteTouchUp: UIButton!
    @IBOutlet weak var txtEmployeeEmail: UITextField!
    @IBOutlet weak var txtEmployeeName: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        if editMode {
            title = "Showing Employee"
           
            btnDeleteTouchUp.isHidden = false
            txtEmployeeName.text = selectedEmployee?.name
            txtEmployeeEmail
                .text = selectedEmployee?.email
        } else {
            title = "Adding new Employee"
            btnDeleteTouchUp.isHidden = true
        }

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSave(_ sender: Any)  {
        
        //let studentEmail : String! = txtEmail.text
        if let employeeName : String = txtEmployeeName.text {
            
            if employeeName.count < 3 {
                print("Please, enter a Employee name with at least 3 chars!")
                return
            }
            
            
            
            if editMode {
                let newEmployee = Employee(context: context)
              
                newEmployee.name = employeeName
                newEmployee.email = txtEmployeeEmail.text
                
                //selectedStudent!.setName(name: studentName)
                //selectedStudent!.setEmail(email: studentEmail)
                
            
            } else {
                let newEmployee = Employee(context: context)
                newEmployee.uuid = UUID()
                newEmployee.name = employeeName
                newEmployee.email = txtEmployeeEmail.text
                
                
                
                
                do {
                    try CoreDataProvider.save(context: self.context)
                    print("Saved")
                   
                } catch {
                  
                }

            }
           
            delegate?.refresh()  /// auto-refresh the list - don't touch this code
            
            navigationController!.popViewController(animated: true)
            
            
        } else {
            print("Enter a valid name!")
        }
        
    }
    @IBAction func btnDeleteTouchUp(_ sender: Any) {
        
        
        
       
        
        
        let employee = selectedEmployee!
       
        if let employeeId = selectedEmployee?.id {
            do {
                
                
                try CoreDataProvider.delete(context: self.context, objectToDelete: employee)
                
            } catch {
                
            }
            //CoreDataProvider.delete(context: self.context, objectToDelete: employee)
            
        
        delegate?.refresh()
        navigationController?.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CoreDataProvider.all(context: self.context, entityName: "Employee").count
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let employee = CoreDataProvider.all(context: self.context, entityName: "Employee")[indexPath.row]
        //let student = StudentProvider.all(context: self.context)[indexPath.row]
        cell.textLabel?.text = "Aafrin ,Sayani "
        //cell.textLabel?.text = "\(Employee.name!), \(Employee.email!)"
        
        return cell
    }



}
