import UIKit

class FilterTableViewController: UITableViewController {
    
    @IBOutlet weak var labelOpenNow: UILabel!
    @IBOutlet weak var switchOpenClose: UISwitch!
    @IBOutlet weak var switchDeal: UISwitch!
    var isExpanded2 = true
    var isExpanded3 = true
    
    
   // var filters  = [Int:String]()
    let headers = ["Price", "Most Popular" , "Distance" , "Sort By"]
    //section 1 price is not searchable via Yelp API
    
    //section 2
    //deals_filter 	bool 	optional
    //is_closed 	bool
    var category = ["deal": false , "is_closed": true]
    
   //section 3
   //number 	optional 	Search radius in meters
    var radius_filterOptions =   [0,5,10,20]
    var radius_filter  = 0
    //section 4
    //Sort mode: 0=Best matched (default), 1=Distance, 2=Highest Rated.
   // let sortOrderOptions = [ 0,1,2]
    let sortOrderOptions1 = [ 0:"Best match"  ,1:"Distance"  ,  2:"Highest rate" ]
    var sortOrder = 0
    
    @IBAction func switchIsCloseChange(sender: UISwitch) {
        category["is_closed"]  = !category["is_closed"]!

    }
    @IBAction func SwitchDealChange(sender: UISwitch) {
          category["deal"]  = !category["deal"]!
    }
    
    
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        
        navigationController?.popToRootViewControllerAnimated(true )
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Filters"
      
    }

    // MARK: - Table view data source
   override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         println("section : \(indexPath.section) , row \(indexPath.row)")
        switch (indexPath.section ) {
            case 2: radius_filter =  radius_filterOptions[ indexPath.row ]
                   // println (radius_filter)
                    isExpanded2 = !isExpanded2
                    tableView.reloadData()
            case 3: sortOrder =  indexPath.row
                    isExpanded3 = !isExpanded3
                    tableView.reloadData()

            default: return
            }
    }
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var headerString:String = ""
        
        switch section  {
            case 2:  return radius_filter == 0 ? "\(headers[section]) [Auto]" : "\(headers[section]) [\(  radius_filter ) miles]"
            
            case 3: return  "\(headers[section]) [\(sortOrderOptions1[ sortOrder]!)]"
            
            default: return headers[section]
        }
     
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            
        case 2: if isExpanded2   {
            return radius_filterOptions.count
        } else {
            return 1
            }
            
        case 3: if isExpanded3  {
            return sortOrderOptions1.count
            } else {
            return 1
            }
            
        case 0: return 1
        case 1: return 2
        default: return 0
            
        }
    }
    
    
    
    
  }
