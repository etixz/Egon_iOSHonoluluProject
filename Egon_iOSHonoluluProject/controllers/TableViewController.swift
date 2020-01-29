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
    
    var artworks = [Artwork]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artworks = DAO.sharedInstance.getAllArtworks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        artworks = DAO.sharedInstance.getAllArtworks()
       
    }
    
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
        return artworks.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ArtworkTableViewCell
        
        let artwork = artworks[indexPath.row]
        currentCell.artTitle.text = artwork.title
        // Configure the cell...

        return currentCell
    }
}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

