//
//  TableViewController.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 29/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import UIKit

class TableViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var artworks = [Artwork]()
    var filteredArt = [Artwork]()
    var searching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artworks = DAO.sharedInstance.getAllArtworks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        artworks = DAO.sharedInstance.getAllArtworks()
       
    }
    
    //Preparing segue: selected cell => detail page of said cell
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "showDetailSegue"{
            //welke cell?
            let cell = sender as! UITableViewCell
            //waar in tabel stond cell?
            let indexPath = tableView.indexPath(for: cell)!
            //welk idea was er in de cell?
            let artwork = artworks[indexPath.row]
            //waar gaan we naartoe
            let detailsVC = segue.destination as! ArtDetailViewController
            //data doorsturen
            detailsVC.artworkToUpdate = artwork
        }
    }
    
    
}

    

    // MARK: - Table view data source
extension TableViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searching{
            return filteredArt.count
        }else{
            return artworks.count
        }
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArtworkTableViewCell
        if searching{
            let artwork = filteredArt[indexPath.row]
            currentCell.artTitle.text = artwork.title
            currentCell.artCreator.text = artwork.creator
        }else{
        
        let artwork = artworks[indexPath.row]
        currentCell.artTitle.text = artwork.title
        currentCell.artCreator.text = artwork.creator
        // Configure the cell...
        }
        return currentCell
    }
}
    // MARK: - SearchBar

 extension TableViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        if searchText.isEmpty{
            searching = false
            tableView.reloadData()
        }else{
        filteredArt = artworks.filter{ $0.title!.range(of: searchText, options: .caseInsensitive) != nil }
        searching = true
        tableView.reloadData()
        }
    }
     func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
     }
}
