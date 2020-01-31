//
//  ArtDetailController.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 29/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ArtDetailViewController: UIViewController, MKMapViewDelegate{
    
    var artworkToUpdate:Artwork?
    @IBOutlet weak var artworkMapView: MKMapView!
    
    @IBOutlet weak var artTitleLbl: UILabel!
    @IBOutlet weak var artCreatorLbl: UILabel!
    @IBOutlet weak var artDateLbl: UILabel!
    @IBOutlet weak var artDescriptionTV: UITextView!
    
    override func viewDidLoad() {
        artworkMapView.addAnnotation(artworkToUpdate!)
        let visRegion = MKCoordinateRegion.init(center: artworkToUpdate!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        artworkMapView.region = visRegion
        if let selectedArtwork = artworkToUpdate{
            artTitleLbl.text = selectedArtwork.title
            artCreatorLbl.text = selectedArtwork.creator
            artDateLbl.text = selectedArtwork.date
            artDescriptionTV.text = selectedArtwork.artDescription
        }
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
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "zoomOnArtworkSegue"{
                let detailsVC = segue.destination as! ViewController
                detailsVC.artworkToZoomInOn = artworkToUpdate
                detailsVC.artworks.append(artworkToUpdate!)
            }
        }
}
