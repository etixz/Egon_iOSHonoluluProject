//
//  Artwork.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 29/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import Foundation
import MapKit

class Artwork: NSObject, MKAnnotation{
    
    var creator:String
    var date:String
    var artDescription:String
    var title:String?
    var coordinate: CLLocationCoordinate2D
    var image: UIImage? = nil
    

    init(creator: String, date: String, artDescription: String, title: String, coordinate: CLLocationCoordinate2D) {
        self.creator = creator
        self.date = date
        self.artDescription = artDescription
        self.title = title
        self.coordinate = coordinate
    }
    
    
}
