//
//  CollectionView.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView
{
    func setupConstraints(superView: UIView, topView: UIView)
    {
        // Calculate view height - divide superview by 3 or 4
        //let heightConstant = superView.frame.height / 4
        
        // Set constraints on the view's position
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30.0),
                                     leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 0),
                                     rightAnchor.constraint(equalTo: superView.rightAnchor, constant: 0),
                                     heightAnchor.constraint(equalToConstant: 120.0)])
    }
}
