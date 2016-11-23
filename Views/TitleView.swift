//
//  TitleView.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class TitleView: UIView
{
    let title: UILabel = UILabel()
    
    func configure()
    {
        backgroundColor = #colorLiteral(red: 0.0005207051872, green: 0.2769836485, blue: 0.3728633225, alpha: 1)
        
        // Configure title
        title.text = "Add or Subtract"
        title.font = UIFont(name: "HelveticaNeue-Medium", size: 16.0)
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title.frame.size = title.intrinsicContentSize
        
        addSubview(title)
    }
    
    func setupConstraints(superView: UIView)
    {
        // Set constraints on the view's position
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: superView.topAnchor, constant: 0),
            leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 0),
            rightAnchor.constraint(equalTo: superView.rightAnchor, constant: 0),
            heightAnchor.constraint(equalToConstant: 64)])
        
        // Set constraints on the title
        title.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                     title.centerXAnchor.constraint(equalTo: centerXAnchor)])
    }
}
