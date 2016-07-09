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
    private let largeCellID = "largeCellID"
    private let headerID = "headerID"
    
    var featuredApps: FeaturedApps?
    var appCategories: [AppCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Featured"
        //get appcategories
        AppCategory.fetchFeaturedApps { (featuredApps) in
            self.featuredApps = featuredApps
            self.appCategories = featuredApps.appCategories
            self.collectionView?.reloadData()
        }
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.registerClass(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellID)
        
        collectionView?.registerClass(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let count = appCategories?.count{
            return count
        }else{
            return 0
        }
        
    }
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.item == 2{
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier(largeCellID, forIndexPath: indexPath) as! LargeCategoryCell
            cell.appCategory = appCategories?[indexPath.item]
            cell.featuredAppsController = self
            return cell
        }
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        cell.featuredAppsController = self
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.item == 2{
            return CGSizeMake(view.frame.width, 160)
        }
        return CGSizeMake(view.frame.width, 230)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 120)
    }
    
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerID, forIndexPath: indexPath) as! Header
        header.appCategory = featuredApps?.bannerCategory
        return header
    }
    
    func showAppsDetailForApp(app: App)
    {
        let layout = UICollectionViewFlowLayout()
        let appDetailController = AppDetailController(collectionViewLayout: layout)
        appDetailController.app = app
        navigationController?.pushViewController(appDetailController, animated: true)
    }
    
}
class LargeCategoryCell: CategoryCell{
    
    private let cellID = "celliD"
    override func setupViews() {
        super.setupViews()
        appsCollectionView.registerClass(LargeAppCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(frame.width/2 + 50, frame.height - 32)
    }
    
    private class LargeAppCell:AppCell{
        private override func setupViews() {
            appImg.translatesAutoresizingMaskIntoConstraints = false
            addSubview(appImg)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appImg]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-2-[v0]-14-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appImg]))
            
            
        }
    }
    
}
class Header: CategoryCell{
    private let headerCellID = "celliD"
    override func setupViews() {
        appsCollectionView.registerClass(BannerCell.self, forCellWithReuseIdentifier: headerCellID)
        appsCollectionView.delegate = self
        appsCollectionView.dataSource = self
        
        addSubview(appsCollectionView)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(headerCellID, forIndexPath: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(200, frame.height - 32)
    }
    override func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    private class BannerCell:AppCell{
        private override func setupViews() {
            appImg.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).CGColor
            appImg.layer.borderWidth = 0.5
            appImg.layer.cornerRadius = 0
            appImg.translatesAutoresizingMaskIntoConstraints = false
            addSubview(appImg)
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appImg]))
            addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appImg]))
            
            
        }
    }
}