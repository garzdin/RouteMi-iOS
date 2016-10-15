//
//  RoutesTableViewController.swift
//  RouteMiApp
//
//  Created by Teodor on 13/04/16.
//  Copyright © 2016 TeodorGarzdin. All rights reserved.
//

import UIKit

class RoutesTableViewController: UITableViewController {
    
    @IBOutlet var routesTableView: UITableView!
    var indicator = UIActivityIndicatorView()
    var routes: [Route] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityIndicator()
        self.getData()
    }
    
    // MARK: - Activity indicatior configuration
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        indicator.activityIndicatorViewStyle = .gray
        indicator.center = CGPoint(x: self.view.center.x, y: self.view.center.y - self.tabBarController!.tabBar.frame.size.height)
        self.view.addSubview(indicator)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Send detail view data
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showRouteDetail" {
            if let destination = segue.destinationViewController as? RouteDetailViewController {
                if let routeIndex = (tableView.indexPathForSelectedRow as NSIndexPath?)?.row {
                    if let id = self.routes[routeIndex].id as String? {
                        destination.routeId = id
                    }
                    if let name = self.routes[routeIndex].name as String? {
                        destination.routeStringName = name
                    }
                    if let timestamp = self.routes[routeIndex].createdAt as Date? {
                        destination.routeStringTimestamp = Formatter.elapsedTime(timestamp)
                    }
                    if let description = self.routes[routeIndex].description as String? {
                        destination.routeStringDescription = description
                    }
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.routes.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "routeCell", for: indexPath) as! RouteTableViewCell
        cell.routeId = self.routes[(indexPath as NSIndexPath).row].id
        cell.routeName.text = self.routes[(indexPath as NSIndexPath).row].name
        cell.routeCreatedTimeAgo.text = Formatter.elapsedTime(self.routes[(indexPath as NSIndexPath).row].createdAt!)
        cell.routeDescription.text = self.routes[(indexPath as NSIndexPath).row].description
        return cell
    }
    
    // MARK: - Get data from API
    
    func getData() {
        if !(self.refreshControl?.isRefreshing)! {
            indicator.startAnimating()
        }
        RequestFactory.request("/routes", type: .GET, headers: nil, addAPIKey: true, params: nil, completionHandler: {
            (data) in
            if let routes = data["routes"] as? [[String: AnyObject]] {
                self.routes = []
                for route in routes {
                    self.routes.append(Route(jsonDictionary: route))
                }
            }
            DispatchQueue.main.async(execute: {
                self.tableView.reloadData()
                if !(self.refreshControl?.isRefreshing)! {
                    self.indicator.stopAnimating()
                }
            })
        })
    }
    
    // MARK: - Pull to refresh action

    @IBAction func refreshRoutesAction(_ sender: UIRefreshControl) {
        getData()
        self.refreshControl?.endRefreshing()
    }
}
