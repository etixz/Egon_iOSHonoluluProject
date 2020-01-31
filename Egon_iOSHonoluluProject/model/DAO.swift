//
//  DAO.swift
//  Egon_iOSHonoluluProject
//
//  Created by mobapp03 on 29/01/2020.
//  Copyright © 2020 mobapp03. All rights reserved.
//

import Foundation
import MapKit
import CoreData

class DAO{
    
    static var sharedInstance:DAO = DAO.init()
    private init(){}
    
    lazy var persistentContainer:NSPersistentContainer = {
        let container = NSPersistentContainer.init(name: "Model")
        container.loadPersistentStores(completionHandler: {
            (storeDescription, error) in
            //hierin komt fouthandeling
        })
        return container
    }()     //functie uitvoeren met haakjes
    
    //zorgen voor opslag, wijzigingen in app doorduwen naar DataBase
    private func saveContext(){
        let context = persistentContainer.viewContext
        if context.hasChanges{
            do {
                try context.save()
            } catch {
                let fout = error as NSError
                print("fout \(fout.description)")
            }
        }
    }
    
    func getAllArtworks() -> [Artwork]{
    var artList = [Artwork]()
    let url = URL.init(string: "https://data.honolulu.gov/resource/yef5-h88r.json")

        do {
            let data = try Data.init(contentsOf: url!)
            let jsonArray = try JSONSerialization.jsonObject(with: data) as! [NSObject]
            
            for item in jsonArray{
                var creator:String
                if let toCheck = item.value(forKey: "creator"){
                    creator = toCheck as! String
                }else{
                    creator = "Unknown"
                }
                var date:String
                if let toCheck = item.value(forKey: "date"){
                    date = toCheck as! String
                }else{
                    date = "Unknown"
                }
                var title:String
                if let toCheck = item.value(forKey: "title"){
                    title = toCheck as! String
                }else{
                    title = "Unknown"
                }
                var lat:Double
                if let toCheck = item.value(forKey: "latitude"){
                    let latText = toCheck as! String
                    lat = Double.init(latText)!
                }else{
                    lat = 1
                }
                var long:Double
                if let toCheck = item.value(forKey: "longitude"){
                    let longText = toCheck as! String
                    long = Double.init(longText)!
                }else{
                    long = 1
                }
               
                let description = item.value(forKey: "description") as! String
                let artwork = Artwork.init(creator: creator, date: date, artDescription: description, title: title, coordinate: CLLocationCoordinate2DMake(lat,long))
                artList.append(artwork)
            }
        }catch{
            print("ah wupsie")
        }
        return artList
    }
    
}
