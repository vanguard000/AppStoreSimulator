//
//  AppDetailController.swift
//  AppStoreSample
//
//  Created by MacOS on 7/9/16.
//  Copyright © 2016 MacOS. All rights reserved.
//

import UIKit

class AppDetailController: UICollectionViewController, UICollectionViewDelegateFlowLayout{
    
    private let headerID = "headerID"
    var app: App?{
        didSet{
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.alwaysBounceVertical = true
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
    }
    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: headerID, forIndexPath: indexPath) as! AppDetailHeader
        header.app = app
        return header
        
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(view.frame.width, 170)
    }
    
    
}

class AppDetailHeader: BaseCell {
    
    var app: App?{
        didSet{
            if let imgName = app?.imageName{
                imageView.image = UIImage(named: imgName)
            }
            nameLabel.text = app?.name
            if let price = app?.price{
                buyBtn.setTitle("$\(price)", forState: .Normal)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .ScaleAspectFill
        iv.backgroundColor = UIColor.yellowColor()
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    //name
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFontOfSize(16)
        label.text = "TEXT"
        return label
    }()
    //Buy button
    let buyBtn: UIButton = {
        let button = UIButton(type: .System)
        button.setTitle("BUY", forState: .Normal)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).CGColor
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.systemFontOfSize(14)
        return button
    }()
    let dividerLine: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        
        return view
    }()
    
    let segmentedController: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details","Reviews","Related"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.selectedSegmentIndex = 0
        sc.tintColor = UIColor.darkGrayColor()
        return sc
    }()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(imageView)
        addSubview(segmentedController)
        addSubview(nameLabel)
        addSubview(buyBtn)
        addSubview(dividerLine)
        
        
        addConstraintsWithVisualFormat("H:|-14-[v0(100)]-8-[v1]|", views: imageView, nameLabel)
        addConstraintsWithVisualFormat("V:|-14-[v0(100)]", views: imageView)
        
        addConstraintsWithVisualFormat("V:|-14-[v0(20)]", views: nameLabel)
        
        addConstraintsWithVisualFormat("H:|-40-[v0]-40-|", views: segmentedController)
        addConstraintsWithVisualFormat("V:[v0(34)]-8-|", views: segmentedController)
        
        addConstraintsWithVisualFormat("H:[v0(60)]-14-|", views: buyBtn)
        addConstraintsWithVisualFormat("V:[v0(32)]-56-|", views: buyBtn)
        
        addConstraintsWithVisualFormat("H:|[v0]|", views: dividerLine)
        addConstraintsWithVisualFormat("V:[v0(0.5)]|", views: dividerLine)
        
    }
}

class BaseCell: UICollectionViewCell{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
    }
}
