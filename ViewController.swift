//
//  ViewController.swift
//  MyCoreData
//  10/18/2021
import UIKit
//0) Add import for CoreData
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var itemSold: UITextField!
    @IBOutlet weak var retailPrice: UITextField!
    @IBOutlet weak var soldPrice: UITextField!
    @IBOutlet weak var marketplace: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBAction func btnEdit(_ sender: UIButton) {
        //**Begin Copy**
        
        //0a Edit sales
        itemSold.isEnabled = true
        retailPrice.isEnabled = true
        soldPrice.isEnabled = true
        marketplace.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        itemSold.becomeFirstResponder()
        
        //**End Copy**
    }
    
    
    @IBAction func btnSave(_ sender: AnyObject) {
        //**Begin Copy**
        //1 Add Save Logic
        
        
        if (salesdb != nil)
        {
            
            salesdb.setValue(itemSold.text, forKey: "Item Sold")
            salesdb.setValue(retailPrice.text, forKey: "Retail Price")
            salesdb.setValue(soldPrice.text, forKey: "Sold Price")
            salesdb.setValue(marketplace.text, forKey: "Marketplace")
            
        }
        else
        {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Sales",in: managedObjectContext)
            
            let sales = Sales(entity: entityDescription!,
                                  insertInto: managedObjectContext)
            
            Sales.itemSold = itemSold.text!
            sales.retailPrice = retailPrice.text!
            sales.soldPrice = soldPrice.text!
            sales.marketplace = marketplace.text!
        }
        var error: NSError?
        do {
            try managedObjectContext.save()
        } catch let error1 as NSError {
            error = error1
        }
        
        if let err = error {
            //if error occurs
           // status.text = err.localizedFailureReason
        } else {
            self.dismiss(animated: false, completion: nil)
            
        }
        //**End Copy**
    }
    
    @IBAction func btnBack(_ sender: AnyObject) {
        
        //**Begin Copy**
        //2) Dismiss ViewController
       self.dismiss(animated: true, completion: nil)
//       let detailVC = ContactTableViewController()
//        detailVC.modalPresentationStyle = .fullScreen
//        present(detailVC, animated: false)
        //**End Copy**
    }
    
    //**Begin Copy**
    //3) Add ManagedObject Data Context
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //**End Copy**
    
    
    //**Begin Copy**
    //4) Add variable salesdb (used from UITableView
    var salesdb:NSManagedObject!
    //**End Copy**
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //**Begin Copy**
        //5 Add logic to load db. If salesdb has content that means a row was tapped on UiTableView
        
        
        if (salesdb != nil)
        {
           itemSold.text = salesdb.value(forKey: "item sold") as? String
            retailPrice.text = salesdb.value(forKey: "retail price") as? String
            soldPrice.text = salesdb.value(forKey: "sold price") as? String
            marketplace.text = salesdb.value(forKey: "marketplace") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            itemSold.isEnabled = false
            retailPrice.isEnabled = false
            marketplace.isEnabled = false
            

            btnSave.isHidden = true
        }else{
          
            btnEdit.isHidden = true
            itemSold.isEnabled = true
            retailPrice.isEnabled = true
            soldPrice.isEnabled = true
            marketplace.isEnabled = true
        }
        itemSold.becomeFirstResponder()
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //**End Copy**
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //**Begin Copy**
    //6 Add to hide keyboard
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil {
            DismissKeyboard()
        }
    }
    //**End Copy**
    
    
    //**Begin Copy**
    //7 Add to hide keyboard
    
    @objc func DismissKeyboard(){
        //forces resign first responder and hides keyboard
        itemSold.endEditing(true)
        retailPrice.endEditing(true)
        soldPrice.endEditing(true)
        marketplace.endEditing(true)
        
    }
    //**End Copy**
    
    //**Begin Copy**
    
    //8 Add to hide keyboard
    
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
        textField.resignFirstResponder()
        return true;
    }
    //**End Copy**
}
