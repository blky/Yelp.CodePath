import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate {
    var client: YelpClient!
    //var restaurants:Array()
    var restaurants = []
    var searchTerm = "Restaurant"

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    let yelpConsumerKey = "vxKwwcR_NMQ7WaEiQBK_CA"
    let yelpConsumerSecret = "33QCvh5bIF5jIHR5klQr7RtBDhQ"
    let yelpToken = "uRcRswHFYa1VkDrGV6LAW2F8clGh5JHV"
    let yelpTokenSecret = "mqtKIxMIR4iBtBPZCmCLEb-Dz3Y"
  
   
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @IBAction func donedone(segue: UIStoryboardSegue) {
        let  svc:FilterTableViewController = segue.sourceViewController as FilterTableViewController
        println("filter result is \(svc.category), radius filter is \(svc.radius_filter) , sort order is \(svc.sortOrder)")
        
        let deal = svc.category["deal"] as  Bool!
        let is_closed = svc.category["is_close"] as  Bool!
        
        client.searchWithFilters(self.searchTerm, radius: svc.radius_filter * 1610, deals: deal, sort: svc.sortOrder,   success: {  (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            
            //println(response)
            self.restaurants = response["businesses"] as NSArray
            self.tableView.reloadData()
            
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        }
    }
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchTerm  = searchText
        
        self.getYelpData(searchText)
        tableView.reloadData()
            if(searchText == ""){
                searchBar.resignFirstResponder()
            }
    }
    func filterSetted (category:[String:Bool] ,distance:Bool,sort:Int){
        
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        searchBar.resignFirstResponder()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
       // tableView.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.titleView = self.searchBar
        getYelpData(searchTerm)
        searchBar.text = searchTerm
        
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    func refresh( refreshControl : UIRefreshControl)
    {
        refreshControl.beginRefreshing()
        getYelpData(searchTerm)
        refreshControl.endRefreshing()
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.restaurants.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("yelpCell") as YelpTableViewCell
        cell.insertValue (restaurants [indexPath.row] as NSDictionary)
        cell.labelRname.text = "\(indexPath.row + 1). \(cell.labelRname.text!)"
        return cell
    }
    func getYelpData(term: NSString) {
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        client.searchWithTerm(term, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            //println(response)
            self.restaurants = response["businesses"] as NSArray
            self.tableView.reloadData()
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
}

