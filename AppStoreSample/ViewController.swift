//
//  ViewController.swift
//  AppStoreSample
//
//  Created by MacOS on 7/8/16.
//  Copyright © 2016 MacOS. All rights reserved.
//

import UIKit

class FeaturedAppsController: UICollectionViewController,  UICollectionViewDelegateFlowLayout{

    private let cellID = "cellID"
    
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Featured"
        //get appcategories
        AppCategory.fetchFeaturedApps { (appCategories) in
            self.appCategories = appCategories
            self.collectionView?.reloadData()
        }
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(CategoryCell.self, forCellWithReuseIdentifier: cellID)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = appCategories?.count{
            return count
        }else{
            return 0
        }
        
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 230)
    }
}

