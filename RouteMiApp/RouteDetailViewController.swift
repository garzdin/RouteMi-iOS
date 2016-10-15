//
//  RouteDetailViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 14/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Mapbox

class RouteDetailViewController: UIViewController {
    
    var coordinates: [CLLocationCoordinate2D] = []
    
    var routeId: String = "" {
        didSet {
            getData()
        }
    }
    
    var routeStringName: String = ""
    var routeStringTimestamp: String = ""
    var routeStringDescription: String = ""
    
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeTimestamp: UILabel!
    @IBOutlet weak var routeDescription: UILabel!

    @IBOutlet weak var routeMapVIew: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.routeName.text = routeStringName
        self.routeTimestamp.text = routeStringTimestamp
        self.routeDescription.text = routeStringDescription
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Get data from API
    
    func getData() {
        RequestFactory.request("/route/\(routeId)/pois/", type: .GET, headers: nil, addAPIKey: true, params: nil, completionHandler: {
            (data) in
            if let pois = data["pois"] as? [[String: AnyObject]] {
                if pois.count > 0 {
                    for poi in pois {
                        if let coordinate = poi["coordinates"] as? [String: AnyObject] {
                            if let latitude = coordinate["latitude"] as? CLLocationDegrees {
                                if let longitude = coordinate["longitude"] as? CLLocationDegrees {
                                    self.coordinates.append(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
                                }
                            }
                        }
                    }
                    let bounds = MGLCoordinateBoundsMake(self.coordinates[0], self.coordinates[self.coordinates.count - 1])
                    self.routeMapVIew.setVisibleCoordinateBounds(bounds, animated: true)
                    let line = MGLPolyline(coordinates: &self.coordinates, count: UInt(self.coordinates.count))
                    DispatchQueue.main.async(execute: {
                        self.routeMapVIew.addAnnotation(line)
                    })
                }
            }
        })
    }

}
