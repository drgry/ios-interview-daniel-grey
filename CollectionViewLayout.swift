//
//  CollectionViewLayout.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

struct CellDiameter
{
    static let standard: CGFloat = 50
    static let inBetween: CGFloat = 75
    static let featured: CGFloat = 100
}

class CollectionViewLayout: UICollectionViewFlowLayout
{
    // The amount the user needs to scroll before the featured cell changes
    let dragOffset: CGFloat = 100.0
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    // Returns the item index of the currently featured cell
    var featuredItemIndex: Int
    {
        get
        {
            //Use max to make sure the featureItemIndex is never < 0
            //return max(0, Int(collectionView!.contentOffset.x / dragOffset))
            return 3
        }
    }
    
    // Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
    var nextItemPercentageOffset: CGFloat
    {
        get { return (collectionView!.contentOffset.x / dragOffset) - CGFloat(featuredItemIndex) }
    }
    
    // Returns the width of the collection view
    var width: CGFloat
    {
        get { return collectionView!.bounds.width }
    }
    
    // Returns the height of the collection view
    var height: CGFloat
    {
        get { return collectionView!.bounds.height }
    }
    
    // Returns the number of items in the collection view
    var numberOfItems: Int
    {
        get { return collectionView!.numberOfItems(inSection: 0) }
    }
    
    func configure()
    {
        //let widthHeight = collectionView?.frame.height / 2
        //itemSize = CGSize(width: widthHeight, height: widthHeight)
        minimumLineSpacing = 0
        
        scrollDirection = UICollectionViewScrollDirection.horizontal
    }
    
    override func prepare()
    {
        scrollDirection = UICollectionViewScrollDirection.horizontal
        minimumLineSpacing = 40.0
        
        cache.removeAll(keepingCapacity: false)
        
        let standardDiameter = CellDiameter.standard
        let inBetweenDiameter = CellDiameter.inBetween
        let featuredDiameter = CellDiameter.featured
        
        var frame = CGRect.zero
        var x: CGFloat = 0
        
        for item in 0..<numberOfItems
        {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.zIndex = item
            var width = standardDiameter
            var height = standardDiameter
            
            if indexPath.item == featuredItemIndex
            {
                let xOffset = standardDiameter * nextItemPercentageOffset
                x = collectionView!.contentOffset.x - xOffset
                
                height = featuredDiameter
                width = featuredDiameter
            }
            else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems
            {
                let maxX = x + standardDiameter
                height = standardDiameter + max((featuredDiameter - standardDiameter) * nextItemPercentageOffset, 0)
                width = height
                x = maxX - width
            }
            
            frame = CGRect(x: x, y: 0, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            
            x = frame.maxX
        }
    }
    
    // Return all attributes in the cache whose frame intersects with the rect passed to the method
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]?
    {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        
        for attributes in cache { if attributes.frame.intersects(rect) { layoutAttributes.append(attributes) } }
        
        return layoutAttributes
    }
    
    // Return true so that the layout is continuously invalidated as the user scrolls */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool { return true }
}
