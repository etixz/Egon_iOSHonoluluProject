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
    var artworkToZoomInOn:Artwork?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if artworks.isEmpty{
        artworks = DAO.sharedInstance.getAllArtworks()
        honoluluMapView.addAnnotations(artworks)
        let visRegion = MKCoordinateRegion.init(center: CLLocationCoordinate2D(latitude: 21.3972222, longitude: -157.9733333), latitudinalMeters: 50000, longitudinalMeters: 50000)
        honoluluMapView.region = visRegion
        }
        else{
            honoluluMapView.addAnnotations(artworks)
            let visRegion = MKCoordinateRegion.init(center: artworkToZoomInOn!.coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
            honoluluMapView.region = visRegion
            artworks.removeAll()
        }
    }
    
    func registerMapAnnotationViews(){
        honoluluMapView.register(MKAnnotationView.self, forAnnotationViewWithReuseIdentifier: NSStringFromClass(Artwork.self))
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    
        if let poi = annotation as? Artwork{
       
        //nagaan of eral een pin was tekenend
        if let customView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin"){
            //pin bestaat al, opvullen met poi
            customView.image = UIImage(named: "honolulushizzle-2.png")
            customView.annotation = poi
            return customView
        }else{
            //pin bestond niet, pin opbouwen
            let customView = MKPinAnnotationView.init(annotation: poi, reuseIdentifier: "pin")
            customView.image = UIImage(named: "honolulushizzle-2.png")
            customView.canShowCallout = true
            let rightButton = UIButton(type: .detailDisclosure)
            customView.rightCalloutAccessoryView = rightButton
        
            return customView
            }
        }
    return nil
    }

    func mapView(_ mapView: MKMapView,annotationView view: MKAnnotationView,calloutAccessoryControlTapped control: UIControl){
        if control == view.rightCalloutAccessoryView {
            performSegue(withIdentifier: "detailsFromMapSegue", sender: view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "detailsFromMapSegue"{
            //waar gaan we naartoe
            let detailsVC = segue.destination as! ArtDetailViewController
            //data doorsturen
            detailsVC.artworkToUpdate = ((sender as! MKAnnotationView).annotation! as! Artwork)
        }
    }
    
}
