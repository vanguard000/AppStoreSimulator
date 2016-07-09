//
//  CategoryCell.swift
//  AppStoreSample
//
//  Created by MacOS on 7/8/16.
//  Copyright © 2016 MacOS. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{

    var featuredAppsController: FeaturedAppsController?
    var appCategory: AppCategory? {
        didSet{
            if let name = appCategory?.name{
                nameLabel.text = name
            }
            appsCollectionView.reloadData()
        }
    }
    private let cellID = "itemCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    //adding name
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Best New Apps"
        label.font = UIFont.systemFontOfSize(16)
        return label
    }()
    
    // Adding the app icons collectionView in the main collectionViewCell
    lazy var appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //seperator view
    let seperatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.blackColor()
        return view
    }()
    
    func setupViews(){
        backgroundColor = UIColor.clearColor()
        
        addSubview(appsCollectionView)
        addSubview(seperatorView)
        addSubview(nameLabel)
        //constraint for seperator view
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": seperatorView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": appsCollectionView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[name(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["name": nameLabel,"v0": appsCollectionView, "v1": seperatorView]))
        //define the app collectionviewcell 
        appsCollectionView.registerClass(AppCell.self, forCellWithReuseIdentifier: cellID)
        
        
    }
    // 
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategory?.apps?.count{
            return count
        }else{
            return 0
        }
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellID, forIndexPath: indexPath) as! AppCell
        cell.app = appCategory?.apps?[indexPath.item]
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(100, frame.height - 32)
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let app = appCategory?.apps?[indexPath.item]{
            featuredAppsController?.showAppsDetailForApp(app)
        }
    }
    
    
}

class AppCell: UICollectionViewCell{
    
    var app: App?{
        didSet{
            if let name = app?.name{
                nameLabel.text = name
                //calculate the height of name length if the name length is a bit long
                let rect = NSString(string: name).boundingRectWithSize(CGSizeMake(frame.width, 1000), options: NSStringDrawingOptions.UsesFontLeading.union(NSStringDrawingOptions.UsesLineFragmentOrigin), attributes:[NSFontAttributeName: UIFont.systemFontOfSize(14)], context: nil)
                
                if rect.height > 20{
                    categoryLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
                    priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
                }else{
                    categoryLabel.frame = CGRectMake(0, frame.width + 22, frame.width, 20)
                    priceLabel.frame = CGRectMake(0, frame.width + 40, frame.width, 20)
                }
                
                nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 40)
                nameLabel.sizeToFit()
            }
            categoryLabel.text = app?.category
            if let price = app?.price{
                priceLabel.text = "$\(price)"
            }else{
                priceLabel.text = ""
            }
            if let imgName = app?.imageName{
                appImg.image = UIImage(named: imgName)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //Adding the appicon image
    let appImg: UIImageView = {
        let imgView = UIImageView()
//        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "frozen")
        imgView.layer.cornerRadius = 16
        imgView.layer.masksToBounds = true
        imgView.contentMode = .ScaleAspectFill
        
        return imgView
    }()
    //adding name
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFontOfSize(14)
        label.numberOfLines = 2
        return label
    }()
    //add category label
    let categoryLabel: UILabel = {
        let cl = UILabel()
        cl.text = "Entertainment"
        cl.font = UIFont.systemFontOfSize(13)
        cl.textColor = UIColor.darkGrayColor()
        return cl
    }()
    //add price label
    let priceLabel: UILabel = {
        let cl = UILabel()
        cl.text = "$3.99"
        cl.font = UIFont.systemFontOfSize(13)
        cl.textColor = UIColor.darkGrayColor()
        return cl
    }()
    
    func setupViews()
    {
        //add app image
        addSubview(appImg)
        appImg.frame = CGRectMake(0, 0, frame.width, frame.width)
        //add name label
        addSubview(nameLabel)
        nameLabel.frame = CGRectMake(0, frame.width + 2, frame.width, 40)
        //add category label
        addSubview(categoryLabel)
        categoryLabel.frame = CGRectMake(0, frame.width + 38, frame.width, 20)
        //add Price label
        addSubview(priceLabel)
        priceLabel.frame = CGRectMake(0, frame.width + 56, frame.width, 20)
        
    }
}
