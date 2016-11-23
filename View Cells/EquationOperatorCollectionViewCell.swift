//
//  EquationOperatorCollectionViewCell.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 23/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class EquationOperatorCollectionViewCell: UICollectionViewCell
{
    var equationOperator: String = "+"
    
    var centerLabel: EquationOperatorLabel!
    var outerLabel: EquationOperatorLabel!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = nil
        clipsToBounds = true
        
        // Set the center image to 20 less than the frame (100.0)
        let centerViewDimension = frame.height - 20
        let outerViewDimension = centerViewDimension * 0.75
        
        centerLabel = EquationOperatorLabel(frame: CGRect(x: 0.0, y: 0.0, width: centerViewDimension, height: centerViewDimension), labelPosition: EquationOperatorLabelPosition.center)
        outerLabel = EquationOperatorLabel(frame: CGRect(x: 0.0, y: 0.0, width: outerViewDimension, height: outerViewDimension), labelPosition: EquationOperatorLabelPosition.outer)
        
        contentView.addSubview(centerLabel)
        contentView.addSubview(outerLabel)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setupEquationOperatorWith(equationOperator: String)
    {
        self.equationOperator = equationOperator
        
        if equationOperator == "+"
        {
            centerLabel.text = "+"
            outerLabel.text = "-"
        }
        else
        {
            centerLabel.text = "-"
            outerLabel.text = "+"
        }
    }
    
    func setupConstraints()
    {
        // Get each view to setup it's own constraints
        centerLabel.setupConstraints(labelPosition: EquationOperatorLabelPosition.center, contentView: contentView, otherView: nil, equationOperator: equationOperator)
        outerLabel.setupConstraints(labelPosition: EquationOperatorLabelPosition.outer, contentView: contentView, otherView: centerLabel, equationOperator: equationOperator)
    }
}
