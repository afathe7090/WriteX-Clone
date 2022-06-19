//
//  Array+ET.swift
//  WriteX
//
//  Created by Ahmed Fathy on 10/03/2022.
//

import UIKit

extension Array where Element: Equatable  {
    mutating func remove(element: Iterator.Element) {
        guard let index = firstIndex(of: element) else {return}
        remove(at: index)
    }
}
