//
//  AdddendCollectionViewCell.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class AddendCollectionViewCell: UICollectionViewCell
{
    static var spaceBetweenLabels: CGFloat = 0
    
    var index: Int = 0
    
    var outerViewLeft: NumeralLabel!
    var innerViewLeft: NumeralLabel!
    var centerView: NumeralLabel!
    var innerViewRight: NumeralLabel!
    var outerViewRight: NumeralLabel!
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backgroundColor = nil
        clipsToBounds = true
        
        // Set the center image to 20 less than the frame (100.0)
        let centerViewDimension = frame.height - 20
        let innerViewDimension = centerViewDimension * 0.75
        let outerViewDimension = centerViewDimension * 0.5
        
        outerViewLeft = NumeralLabel(frame: CGRect(x: 0.0, y: 0.0, width: outerViewDimension, height: outerViewDimension), labelPosition: NumeralLabelPosition.outerLeft)
        innerViewLeft = NumeralLabel(frame: CGRect(x: 0.0, y: 0.0, width: innerViewDimension, height: innerViewDimension), labelPosition: NumeralLabelPosition.innerLeft)
        centerView = NumeralLabel(frame: CGRect(x: 0.0, y: 0.0, width: centerViewDimension, height: centerViewDimension), labelPosition: NumeralLabelPosition.center)
        innerViewRight = NumeralLabel(frame: CGRect(x: 0.0, y: 0.0, width: innerViewDimension, height: innerViewDimension), labelPosition: NumeralLabelPosition.innerRight)
        outerViewRight = NumeralLabel(frame: CGRect(x: 0.0, y: 0.0, width: outerViewDimension, height: outerViewDimension), labelPosition: NumeralLabelPosition.outerRight)
        
        contentView.addSubview(outerViewLeft)
        contentView.addSubview(innerViewLeft)
        contentView.addSubview(centerView)
        contentView.addSubview(innerViewRight)
        contentView.addSubview(outerViewRight)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
    }
    
    func setupNumeralViewsWith(index: Int)
    {
        self.index = index
        
        let centerViewNumeral = index
        let outerViewLeftNumeral = index - 2
        let innerViewLeftNumeral = index - 1
        let innerViewRightNumeral = index + 1
        let outerViewRightNumeral = index + 2
        
        centerView.text = String(centerViewNumeral)
        outerViewLeft.text = String(outerViewLeftNumeral)
        innerViewLeft.text = String(innerViewLeftNumeral)
        innerViewRight.text = String(innerViewRightNumeral)
        outerViewRight.text = String(outerViewRightNumeral)
        
        // We have setup the numerals - hide any views that are below zero
        if centerViewNumeral == 0 { outerViewLeft.isHidden = true; innerViewLeft.isHidden = true }
        else if centerViewNumeral == 1 { outerViewLeft.isHidden = true }
        else { outerViewLeft.isHidden = false; innerViewLeft.isHidden = false }
    }
    
    func setupConstraints()
    {
        // Calculate even spacing between views
        let totalWidthOfViews = outerViewLeft.frame.width + (innerViewLeft.frame.width * 2) + centerView.frame.width
        let remainingSpace = frame.width - totalWidthOfViews
        AddendCollectionViewCell.spaceBetweenLabels = remainingSpace / 4
        
        // Get each view to setup it's own constraints
        outerViewLeft.setupConstraints(labelPosition: NumeralLabelPosition.outerLeft, contentView: contentView, leftView: nil, spacing: nil)
        innerViewLeft.setupConstraints(labelPosition: NumeralLabelPosition.innerLeft, contentView: contentView, leftView: outerViewLeft, spacing: AddendCollectionViewCell.spaceBetweenLabels)
        centerView.setupConstraints(labelPosition: NumeralLabelPosition.center, contentView: contentView, leftView: innerViewLeft, spacing: AddendCollectionViewCell.spaceBetweenLabels)
        innerViewRight.setupConstraints(labelPosition: NumeralLabelPosition.innerRight, contentView: contentView, leftView: centerView, spacing: AddendCollectionViewCell.spaceBetweenLabels)
        outerViewRight.setupConstraints(labelPosition: NumeralLabelPosition.outerRight, contentView: contentView, leftView: nil, spacing: nil)
    }
}
