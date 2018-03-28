//
//  Objects.swift
//  MySmileApp
//
//  Created by Yicong Gong on 3/27/18.
//  Copyright © 2018 Yicong Gong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Disk

// set up structures
//-----------------------|
//    User               |
//-----------------------|
class User: NSObject{
    
    struct Data: Codable{
        // Critical Info
        var user_ID:String!
        var password:String!
        var email:String!
        
        // User Profile
        var experience:String!
        var exp_id:String!
        var name:String!
        
        // Control
        var userLat:Double!
        var userLng:Double!
        var needLocationUpdate = true
    }
    
    var data = Data() // Initialize a data struct
    
    func save(){
        do{
            try Disk.save(data, to: .caches, as: "User")
        }
        catch {}
    }
    
    func load(){
        do{
            data = try Disk.retrieve("User", from: .caches, as: Data.self)
        }
        catch {}
    }
}

// Friendlist
//-----------------------|
//    Friendlist         |
//-----------------------|
class Friendlist: NSObject{
    
    struct Friend: Codable{
        var exp_id:String!
        var name:String!
    }
    
    var friendlist:[Friend] = []
    
    func addFriend(name:String, exp_id: String){
        let newFriend = Friend(exp_id: exp_id, name: name)
        friendlist.append(newFriend)
    }
    
    func removeFriend( atIndex: Int){
        friendlist.remove(at: atIndex) // Delete the associate row in the Datasource
    }
    
    func save(){
        do{
            try Disk.save(friendlist, to: .caches, as: "Friendlist")
        }
        catch {}
    }
    
    func load(){
        do{
            friendlist = try Disk.retrieve("Friendlist", from: .caches, as: [Friend].self)
        }
        catch {}
    }
}

// Attractions
//-----------------------|
//    Attractions        |
//-----------------------|

class Attractions: NSObject{
    
    struct Attraction: Codable{
        var name:String!
        var attraction_ID:String!
        var lat:String!
        var lng:String!
        var discover:String!
        var url:String!
    }
    
    var attractionList:[Attraction] = []
    
    func save(){
        do{
            try Disk.save(attractionList, to: .caches, as: "AttractionList")
        }
        catch {}
    }
    
    func load(){
        do{
            attractionList = try Disk.retrieve("AttractionList", from: .caches, as: [Attraction].self)
        }
        catch {}
    }
}

// Attraction Marker
//-----------------------|
// Attraction Marker     |
//-----------------------|
func loadMarker(attraction_id:String, url:String) -> UIImage!
{
    do{
        let markerImg = try Disk.retrieve("Markers/" + attraction_id, from: .documents, as: UIImage.self)
        return markerImg
    }
    catch {
        let markerImg = LoadIMG(url: url)
        do{
            try Disk.save(markerImg, to: .documents, as: "Markers/" + attraction_id)
        }
        catch{}
        return markerImg
    }
}

// function to load image as UIImage
func LoadIMG(url: String) -> UIImage!
{
    let icon_url = URL(string: url)!
    let data = try? Data(contentsOf: icon_url)
    let IMG = UIImage(data: data!, scale:2)
    //    let IMG = UIImage(data: data!)
    
    return IMG
}

