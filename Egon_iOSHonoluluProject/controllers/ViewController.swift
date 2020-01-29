//
//  ViewController.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 29/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var honoluluMapView: MKMapView!
    var artworks = [Artwork]()
    let locationManager = CLLocationManager.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        artworks = DAO.sharedInstance.getAllArtworks()
        honoluluMapView.addAnnotations(artworks)
        let visRegion = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: 21.3972222, longitude: -157.9733333), latitudinalMeters: 50000, longitudinalMeters: 50000)
        honoluluMapView.region = visRegion
    }
}

