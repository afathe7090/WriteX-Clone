//
//  UICollectionView+EXT.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 17/06/2022.
//

import Foundation
import UIKit



extension UICollectionView {
    
    
    func configureNibWithIdentifier(identifier: [String]){
        identifier.forEach {
            self.register(UINib(nibName: $0, bundle: nil), forCellWithReuseIdentifier: $0)
        }
        
    }
    
    
    func configureReusableCell(identifier: String, indexPath: IndexPath) -> UICollectionViewCell{
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier,
                                            for: indexPath)
        return cell
        
    }
    
    
    
}
