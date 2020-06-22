//
//  ListVC.swift
//  Map_API
//
//  Created by Abdul Diallo on 6/20/20.
//  Copyright © 2020 Abdul Diallo. All rights reserved.
//

import UIKit
import MapKit

class ListVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var matchItems : [MKMapItem] = [] {
        didSet {
            print(matchItems.count)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }

}


//MARK: - helpers


extension ListVC {

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segues.toPinDetailsFromCVC {
            let destination = segue.destination as! PinDetailsFromCVCell
            guard let selectedItem = collectionView.indexPathsForSelectedItems?.first else { return }
            destination.pin = matchItems[selectedItem.row]
        }
    }

}


//MARK: - delegate and data source


extension ListVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: 100, height: 300)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        matchItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cells.listCell, for: indexPath) as! ListCell
        cell.pin = matchItems[indexPath.row]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.toPinDetailsFromCVC, sender: self)
    }

}


//MARK: - shareMatchingItems

//extension ListVC : shareMatchingItems {
//    func passItems(matchingItems: [MKMapItem]) {
//        self.matchItems = matchingItems
//    }
//}
