//
//  RouteTableViewCell.swift
//  RouteMiApp
//
//  Created by Teodor on 13/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit
import Mapbox
import CoreLocation

class RouteTableViewCell: UITableViewCell {
    
    var routeId: String! = "" {
        didSet {
            getData()
        }
    }
    @IBOutlet weak var routeName: UILabel!
    @IBOutlet weak var routeDescription: UILabel!
    @IBOutlet weak var routeCreatedTimeAgo: UILabel!
    @IBOutlet weak var routeMapView: MGLMapView!
    @IBOutlet weak var shadowBackgroundView: UIView!
    
    var coordinates: [CLLocationCoordinate2D] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        shadowBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
//        shadowBackgroundView.layer.shadowOpacity = 0.4
//        shadowBackgroundView.layer.shadowRadius = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
                    self.routeMapView.setVisibleCoordinateBounds(bounds, animated: true)
                    let line = MGLPolyline(coordinates: &self.coordinates, count: UInt(self.coordinates.count))
                    DispatchQueue.main.async(execute: {
                        [unowned self] in
                        self.routeMapView.addAnnotation(line)
                    })
                }
            }
        })
    }
}
