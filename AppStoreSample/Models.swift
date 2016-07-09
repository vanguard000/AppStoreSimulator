//
//  Models.swift
//  AppStoreSample
//
//  Created by MacOS on 7/8/16.
//  Copyright © 2016 MacOS. All rights reserved.
//

import UIKit

class FeaturedApps: NSObject{
    var bannerCategory: AppCategory?
    var appCategories: [AppCategory]?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "categories"{
            appCategories = [AppCategory]()
            
            
            for dict in value as! [[String: AnyObject]]{
                
                let appCategory = AppCategory()
                
                appCategory.setValuesForKeysWithDictionary(dict)
                appCategories?.append(appCategory)
            }
        }else if key == "bannerCategory"{
            bannerCategory = AppCategory()
            bannerCategory?.setValuesForKeysWithDictionary(value as! [String : AnyObject])
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
}


class AppCategory: NSObject{
    
    var name: String?
    var apps: [App]?
    var type: String?
    
    override func setValue(value: AnyObject?, forKey key: String) {
        if key == "apps"{
            
            apps = [App]()
            for dict in value as! [[String: AnyObject]]{
                let app = App()
                app.setValuesForKeysWithDictionary(dict)
                apps?.append(app)
            }
            
            
        }else{
            super.setValue(value, forKey: key)
        }
    }
    
    static func fetchFeaturedApps(completionHandler:(FeaturedApps) -> ()) {
        let urlString = "http://www.statsallday.com/appstore/featured"
        
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) {
            (data, response, error) in
            if error != nil{
                print(error?.localizedDescription)
                return
            }
            
            do{
                let json = try(NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers))
                let featuredApps = FeaturedApps()
                featuredApps.setValuesForKeysWithDictionary(json as! [String : AnyObject])
                
                dispatch_async(dispatch_get_main_queue(), { 
                    completionHandler(featuredApps)
                })
                
                
            }catch let err{
                print(err)
            }
            
        }.resume()
        
    }
    
    
    static func sampleAppCategories() -> [AppCategory]{
        //first category
        let bestNewAppCategory = AppCategory()
        bestNewAppCategory.name = "Best New Apps"
        var apps = [App]()
        let frozenApp = App()
        frozenApp.name = "Disney Build It: Frozen"
        frozenApp.imageName = "frozen"
        frozenApp.category = "Entertainment"
        frozenApp.price = NSNumber(float: 3.99)
        apps.append(frozenApp)
        

        //second category
        let bestNewGames = AppCategory()
        bestNewGames.name = "Best New Games"
        var bestNewGameApps = [App]()
        let gameApp = App()
        gameApp.name = "Telepaint"
        gameApp.imageName = "telepaint"
        gameApp.category = "Games"
        gameApp.price = NSNumber(float: 3.99)
        bestNewGameApps.append(gameApp)
        
        
        bestNewAppCategory.apps = apps
        bestNewGames.apps = bestNewGameApps
        return [bestNewAppCategory, bestNewGames]
    }
}

class App: NSObject{
    var id: NSNumber?
    var name: String?
    var category: String?
    var imageName: String?
    var price: NSNumber?
}