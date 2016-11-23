//
//  CalculateButton.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 24/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class CalculateButton: UIButton {

    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        setTitle("Calculate!", for: .normal)
        setTitleColor(#colorLiteral(red: 0.2470277846, green: 0.2470766604, blue: 0.2470246851, alpha: 1), for: .normal)
        
        backgroundColor = #colorLiteral(red: 0.9410743117, green: 0.9412353635, blue: 0.9410640597, alpha: 1)
        layer.cornerRadius = 8.0
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setupConstraints(superView: UIView)
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -20.0),
                                     leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 20.0),
                                     bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -20.0),
                                     heightAnchor.constraint(equalToConstant: 50.0)])
    }
}
