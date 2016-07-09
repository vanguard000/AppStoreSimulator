//
//  Extensions.swift
//  AppStoreSample
//
//  Created by MacOS on 7/10/16.
//  Copyright © 2016 MacOS. All rights reserved.
//

import UIKit

extension UIView{
    func addConstraintsWithVisualFormat(format: String, views: UIView...){
        var viewsDict = [String: UIView]()
        for (index, view) in views.enumerate()
        {
            let key = "v\(index)"
            viewsDict[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDict))
    }
}
