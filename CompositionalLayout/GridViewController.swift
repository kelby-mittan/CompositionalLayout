//
//  ViewController.swift
//  CompositionalLayout
//
//  Created by Kelby Mittan on 8/17/20.
//  Copyright © 2020 Kelby Mittan. All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    // 3. setup enum to hold sections for CV
    enum Section {
        case main
    }
    
    @IBOutlet var collectionView: UICollectionView! // default is flow
    
    // 4. declare our data source, which will be using diffable data source
    private var dataSource: UICollectionViewDiffableDataSource<Section, Int>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
    }

    // 2.
    private func configureCollectionView() {
        // change the collectionviews layout
        collectionView.collectionViewLayout = createLayout()
        collectionView.backgroundColor = .systemTeal
    }

    // 1.
    private func createLayout() -> UICollectionViewLayout {
        // 1. Create and config the item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        // 2. Create and config the group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.25))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 4)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        // 3. config the section
        let section = NSCollectionLayoutSection(group: group)
        
        // 4. Config layout
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    // 5. Config the Data Source
    private func configureDataSource() {
        
        // 1. setting up the data source
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "labelCell", for: indexPath) as? LabelCell else {
                fatalError()
            }
            cell.textLabel.text = "\(item)"
            cell.backgroundColor = .systemPurple
            return cell
        })
        
        // 2. setting up the initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        
        snapshot.appendItems(Array(1...100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

