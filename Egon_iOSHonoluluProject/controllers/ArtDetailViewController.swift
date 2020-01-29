//
//  ArtDetailController.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 29/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import Foundation
import UIKit

class ArtDetailViewController: UIViewController{
    
    var artworkToUpdate:Artwork?
    
    @IBOutlet weak var artTitleLbl: UILabel!
    @IBOutlet weak var artCreatorLbl: UILabel!
    @IBOutlet weak var artDateLbl: UILabel!
    @IBOutlet weak var artDescriptionTV: UITextView!
    
    override func viewDidLoad() {
        if let selectedArtwork = artworkToUpdate{
            artTitleLbl.text = selectedArtwork.title
            artCreatorLbl.text = selectedArtwork.creator
            artDateLbl.text = selectedArtwork.date
            artDescriptionTV.text = selectedArtwork.artDescription
        }
    }
    
    
}