import UIKit
import CoreLocation

class YelpTableViewCell: UITableViewCell    {

    var restaurant:Restaurant?
 
    @IBOutlet weak var imgRestaurant: UIImageView!
    @IBOutlet weak var labelRname: UILabel!
    @IBOutlet weak var imgRRating: UIImageView!
    @IBOutlet weak var labelNumberOfReview: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelCategory: UILabel!
    @IBOutlet weak var labelDistance: UILabel!
    
    func insertValue (cellData : NSDictionary){
        
        //println (cellData)
        self.labelRname.text = cellData["name"] as String!
        //println(self.labelRname.text )
         let location:NSDictionary = cellData ["location"] as NSDictionary
        //println (location)
        let address = location ["display_address"] as NSArray!
        let streetAddress = address [0] as String
        let city = location["city"] as String
        labelAddress.text = streetAddress + "," + city
        //println(cellData ["categories"])

        /*if (cellData ["categories"] != nil) {
        
            let categories = cellData ["categories"] as NSArray
            let category = categories [0] as NSArray
            
            var cateAll = category[0] as String
            for var i = 1 ; i < category.count; i++ {
                let temp = category[i] as String
                cateAll = cateAll + "," + temp
            }
            //println(cateAll)
            labelCategory.text = cateAll
        }
        */
        var category:String?
        
        if let categories = cellData["categories"] as? Array<Array<String>> {
            category =  ", ".join(categories.map({ $0[0] }))
        }
        labelCategory.text = category
        
        let reviewCount = cellData["review_count"] as Int
        
        let distance = (cellData["distance"] as Double) / 1610.0
        let distanceF  = String(format: "%.2f mi", distance )
        self.labelDistance.text = distanceF
       
        labelNumberOfReview.text = "\(reviewCount) Reviews"
        if let tempImg = cellData ["rating_img_url_small"] as String!
        {
            imgRRating.setImageWithURL(NSURL(string: tempImg))
        }
        if let tempImg = cellData ["image_url"] as String!
        {
            imgRestaurant.setImageWithURL(NSURL(string: tempImg))
        }
        
        imgRestaurant.layer.cornerRadius = 9.0
       imgRestaurant.layer.masksToBounds = true
        
        var restaurantAddress = address[0] as String
        for var i = 1 ; i < address.count; i++ {
            let temp = address[i] as String
            restaurantAddress = restaurantAddress + "," + temp
        }
        //println(restaurantAddress)
        //self.labelDistance.text = ""
        /*
        if let coordinate = location ["coordinate"] as? NSDictionary    {
        let latitude:AnyObject = coordinate["latitude"]! as AnyObject
        let latitudeS:String = "\(latitude)" as String
        let latitudeNS = NSString (string: latitudeS)
        let latitudeD = latitudeNS.doubleValue
        
        let longitude:AnyObject = coordinate["longitude"]! as AnyObject
        let longitudeS:String = "\(longitude)" as String
        let longitudeNS = NSString(string: longitudeS)
        let longitudeD =  longitudeNS.doubleValue
        let locR = CLLocation(latitude: latitudeD, longitude: longitudeD)
        let locME = CLLocation(latitude: 37.571284,longitude: -122.033079)
        
        let distance = locR.distanceFromLocation(locME)/1000 * 0.6
        let distanceF  = String(format: "%.1f mi", distance )
        // println (distance)
        self.labelDistance.text = distanceF
        }
        */
        /*  var geocoder:CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(restaurantAddress, {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if error != nil {
                println("Error", error)
            }
            else  if let placemark = placemarks?[0] as? CLPlacemark {
                var placemark:CLPlacemark = placemarks[0] as CLPlacemark
                let lat  = placemark.location.coordinate.latitude
                let long  = placemark.location.coordinate.longitude
                let locRestaurant = CLLocation(latitude: lat, longitude: long)
                //address is :2875 Sand Hill Rd, Menlo Park, CA 94025, coordinates: 37.4201828357191 + -122.2141283997882
                let locME = CLLocation(latitude: 37.4201828357191,longitude: -122.2141283997882)
                let distance = locME.distanceFromLocation(locRestaurant)/1000 * 0.6
                let distanceF  = String(format: "%.1f mi", distance )
               // self.labelDistance.text = distanceF
                /*var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinates
                pointAnnotation.title = "Apple HQ"
                self.mapView.addAnnotation(pointAnnotation)
                self.mapView.centerCoordinate = coordinates
                self.mapView.selectAnnotation(pointAnnotation, animated: true)
                println("Added annotation to map view") */
            }
        })
        
        */
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
