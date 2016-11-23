//
//  ViewController.swift
//  ios-interview-daniel-grey
//
//  Created by Daniel Grey on 22/11/16.
//  Copyright © 2016 DRG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
{
    let titleView: TitleView = TitleView()
    //let contentView: ContentView = ContentView()
    
    let greeting: UILabel = UILabel()
    
    var firstAddendView: CollectionView!
    var secondAddendView: CollectionView!
    var equationOperatorView: CollectionView!
    
    var calculate: CalculateButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0, green: 0.7570653558, blue: 0.9987798333, alpha: 1)
        
        // Configure title
        titleView.configure()
        view.addSubview(titleView)
        
        // Configure greeting
        greeting.text = "Hello, what will it be today?"
        greeting.font = UIFont(name: "HelveticaNeue", size: 18.0)
        greeting.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        greeting.frame.size = greeting.intrinsicContentSize
        view.addSubview(greeting)
        
        // Each collection view must have it's own layout so it is recognized in numberOfItemsInSection
        let layout1 = createLayout()
        let layout2 = createLayout()
        let layout3 = createLayout()
        
        equationOperatorView = CollectionView(frame: CGRect.zero, collectionViewLayout: layout1)
        firstAddendView = CollectionView(frame: CGRect.zero, collectionViewLayout: layout2)
        secondAddendView = CollectionView(frame: CGRect.zero, collectionViewLayout: layout3)
        
        setupCollectionView(collectionView: equationOperatorView, classType: EquationOperatorCollectionViewCell.self, reuseIdentifier: "equationOperator", viewTag: 1)
        setupCollectionView(collectionView: firstAddendView, classType: AddendCollectionViewCell.self, reuseIdentifier: "firstAddend", viewTag: 0)
        setupCollectionView(collectionView: secondAddendView, classType: AddendCollectionViewCell.self, reuseIdentifier: "secondAddend", viewTag: 2)
        
        view.addSubview(equationOperatorView)
        view.addSubview(firstAddendView)
        view.addSubview(secondAddendView)
        
        // Configure button
        calculate = CalculateButton(frame: CGRect.zero)
        calculate.addTarget(self, action: #selector(calculateButtonTapped(sender:)), for: .touchUpInside)
        
        view.addSubview(calculate)
    }
    
    override func viewDidLayoutSubviews()
    {
        titleView.setupConstraints(superView: self.view)
        //contentView.setupConstraints(superView: self.view, titleView: titleView)
        
        // Set constraints on the greeting
        greeting.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([greeting.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 20.0),
                                     greeting.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        
        // Set constraints on the addend views
        firstAddendView.setupConstraints(superView: self.view, topView: greeting)
        equationOperatorView.setupConstraints(superView: self.view, topView: firstAddendView)
        secondAddendView.setupConstraints(superView: self.view, topView: equationOperatorView)
        
        // Set constraints on the calculate button
        calculate.setupConstraints(superView: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if collectionView.tag == 0 || collectionView.tag == 2 { return 20 }
        else { return 2 }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        if collectionView.tag == 0
        {
            let cell = firstAddendView.dequeueReusableCell(withReuseIdentifier: "firstAddend", for: indexPath) as! AddendCollectionViewCell
            cell.setupNumeralViewsWith(index: indexPath.row)
            cell.setupConstraints()
            return cell
        }
        else if collectionView.tag == 1
        {
            let cell = equationOperatorView.dequeueReusableCell(withReuseIdentifier: "equationOperator", for: indexPath) as! EquationOperatorCollectionViewCell
           
            // If it is the first cell it is the addition operator
            if indexPath.row == 0 { cell.setupEquationOperatorWith(equationOperator: "+") }
            else { cell.setupEquationOperatorWith(equationOperator: "-")  }
            cell.setupConstraints()
            return cell
        }
        else
        {
            let cell = secondAddendView.dequeueReusableCell(withReuseIdentifier: "secondAddend", for: indexPath) as! AddendCollectionViewCell
            cell.setupNumeralViewsWith(index: indexPath.row)
            cell.setupConstraints()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)
    {
        if collectionView.tag == 0 || collectionView.tag == 2
        {
            if let tempCell = cell as? AddendCollectionViewCell
            {
                tempCell.outerViewLeft.layer.opacity = 0.0
                tempCell.innerViewLeft.layer.opacity = 0.0
                tempCell.innerViewRight.layer.opacity = 0.0
                tempCell.outerViewRight.layer.opacity = 0.0
                
                UIView.animate(withDuration: 2.0, animations: {
                    tempCell.outerViewLeft.layer.opacity = 0.5
                    tempCell.innerViewLeft.layer.opacity = 0.5
                    tempCell.innerViewRight.layer.opacity = 0.5
                    tempCell.outerViewRight.layer.opacity = 0.5
                })
            }
        }
        else
        {
            if let tempCell = cell as? EquationOperatorCollectionViewCell
            {
                tempCell.outerLabel.layer.opacity = 0.0
                
                UIView.animate(withDuration: 2.0, animations: {
                    tempCell.outerLabel.layer.opacity = 0.5
                })
            }
        }
    }
    
    func createLayout() -> UICollectionViewFlowLayout
    {
        let layout = UICollectionViewFlowLayout()
        
        layout.itemSize = CGSize(width: view.frame.width, height: 120)
        layout.minimumLineSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        return layout
    }
    
    func setupCollectionView(collectionView: UICollectionView, classType: AnyClass, reuseIdentifier: String, viewTag: Int)
    {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(classType, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.tag = viewTag
        
        collectionView.backgroundColor = nil
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
    
    func calculateButtonTapped(sender: AnyObject)
    {
        let alertController = UIAlertController(title: "Result", message: "You're result is...", preferredStyle: UIAlertControllerStyle.alert)
    
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
    
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

