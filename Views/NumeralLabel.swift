//
//  NumeralLabel.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

enum NumeralLabelPosition
{
    case outerLeft
    case innerLeft
    case center
    case innerRight
    case outerRight
}

class NumeralLabel: UILabel
{
    var numeral: Int = 0 // Default value to start with
    
    var diameter: CGFloat!
    var labelPosition: NumeralLabelPosition!
    
    init(frame: CGRect, labelPosition: NumeralLabelPosition)
    {
        super.init(frame: frame)
        
        diameter = frame.width
        self.labelPosition = labelPosition
        
        text = String(numeral)
        
        setupAppearance(labelPosition: self.labelPosition)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setupConstraints(labelPosition: NumeralLabelPosition, contentView: UIView, leftView: UIView?, spacing: CGFloat?)
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch labelPosition
        {
            case .outerLeft:
                NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                             heightAnchor.constraint(equalToConstant: diameter),
                                             centerXAnchor.constraint(equalTo: contentView.leftAnchor),
                                             centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
            case .innerLeft:
                NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                             heightAnchor.constraint(equalToConstant: diameter),
                                             leftAnchor.constraint(equalTo: leftView!.rightAnchor, constant: spacing!),
                                             centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
            case .center:
                NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                             heightAnchor.constraint(equalToConstant: diameter),
                                             leftAnchor.constraint(equalTo: leftView!.rightAnchor, constant: spacing!),
                                             centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
            case .innerRight:
                NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                             heightAnchor.constraint(equalToConstant: diameter),
                                             leftAnchor.constraint(equalTo: leftView!.rightAnchor, constant: spacing!),
                                             centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
            case .outerRight:
                NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                             heightAnchor.constraint(equalToConstant: diameter),
                                             centerXAnchor.constraint(equalTo: contentView.rightAnchor),
                                             centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
        }
    }
    
    func setupAppearance(labelPosition: NumeralLabelPosition)
    {
        backgroundColor = #colorLiteral(red: 0, green: 0.7570653558, blue: 0.9987798333, alpha: 1)
        
        // Bug right here
        layer.masksToBounds = true
        layer.cornerRadius = frame.width / 2.0
        layer.borderWidth = 3.0
        layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 4.0
        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowPath = UIBezierPath(roundedRect: frame, cornerRadius: frame.width / 2.0).cgPath
        
        textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textAlignment = NSTextAlignment.center
        
        switch labelPosition
        {
            case .outerLeft:
                // Begin with opacity zero so animation works
                layer.opacity = 0.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 25.0)
            case .innerLeft:
                layer.opacity = 0.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 37.5)
            case .center:
                layer.opacity = 1.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 50.0)
            case .innerRight:
                layer.opacity = 0.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 37.5)
            case .outerRight:
                layer.opacity = 0.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 25.0)
        }
    }
}
