//
//  EquationOperatorLabel.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 23/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

enum EquationOperatorLabelPosition
{
    case center
    case outer
}

class EquationOperatorLabel: UILabel
{
    var equationOperator: String = "+" // Default value to start with
    
    var diameter: CGFloat!
    var labelPosition: EquationOperatorLabelPosition!
    
    init(frame: CGRect, labelPosition: EquationOperatorLabelPosition)
    {
        super.init(frame: frame)
        
        diameter = frame.width
        self.labelPosition = labelPosition
        
        text = equationOperator
        
        setupAppearance(labelPosition: self.labelPosition)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setupConstraints(labelPosition: EquationOperatorLabelPosition, contentView: UIView, otherView: UIView?, equationOperator: String)
    {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch labelPosition
        {
            case .center:
                NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                             heightAnchor.constraint(equalToConstant: diameter),
                                             centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                             centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
            case .outer:
                if equationOperator == "+"
                {
                    NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                                 heightAnchor.constraint(equalToConstant: diameter),
                                                 leftAnchor.constraint(equalTo: otherView!.rightAnchor, constant: AddendCollectionViewCell.spaceBetweenLabels),
                                                 centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
                }
                else
                {
                    NSLayoutConstraint.activate([widthAnchor.constraint(equalToConstant: diameter),
                                                 heightAnchor.constraint(equalToConstant: diameter),
                                                 rightAnchor.constraint(equalTo: otherView!.leftAnchor, constant: -AddendCollectionViewCell.spaceBetweenLabels),
                                                 centerYAnchor.constraint(equalTo: contentView.centerYAnchor)])
                }
        }
    }
    
    func setupAppearance(labelPosition: EquationOperatorLabelPosition)
    {
        backgroundColor = #colorLiteral(red: 0.9539447427, green: 0.4393890202, blue: 0.4407442808, alpha: 1)
        
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
            case .center:
                layer.opacity = 1.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 50.0)
            case .outer:
                // Begin with opacity zero so animation works
                layer.opacity = 0.0
                font = UIFont(name: "HelveticaNeue-Medium", size: 37.5)
        }
    }
}
