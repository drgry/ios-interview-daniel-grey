//
//  ContentView.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class ContentView: UIView, UICollectionViewDelegate, UICollectionViewDataSource
{
    let greeting: UILabel = UILabel()
    
    let firstAddendView: CollectionView = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    let secondAddendView: CollectionView = CollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewLayout())
    
    func configure()
    {
        backgroundColor = #colorLiteral(red: 0, green: 0.7570653558, blue: 0.9987798333, alpha: 1)
        
        // Configure greeting
        greeting.text = "Hello, what will it be today?"
        greeting.font = UIFont(name: "HelveticaNeue", size: 18.0)
        greeting.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        greeting.frame.size = greeting.intrinsicContentSize
        
        addSubview(greeting)
        
        firstAddendView.delegate = self
        secondAddendView.delegate = self
        
        secondAddendView.dataSource = self
        firstAddendView.dataSource = self
        
        addSubview(secondAddendView)
        addSubview(firstAddendView)
    }
    
    func setupConstraints(superView: UIView, titleView: UIView)
    {
        // Set constraints on the view's position
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 0),
                                     leftAnchor.constraint(equalTo: superView.leftAnchor, constant: 0),
                                     rightAnchor.constraint(equalTo: superView.rightAnchor, constant: 0),
                                     bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: 0)])
        
        // Set constraints on the greeting
        greeting.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([greeting.topAnchor.constraint(equalTo: topAnchor, constant: 20.0),
                                     greeting.centerXAnchor.constraint(equalTo: centerXAnchor)])
        
        // Set constraints on the addend views
        firstAddendView.setupConstraints(superView: self, topView: greeting)
        secondAddendView.setupConstraints(superView: self, topView: firstAddendView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = OperatorCollectionViewCell()
        cell.configure()
        return cell
    }
}
