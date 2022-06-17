//
//  DataSourceHandelar.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 17/06/2022.
//

import Foundation
import RxDataSources


struct SectionDataSources<Element> {
    
    var header: String
    var items: [Element]
}

extension SectionDataSources: SectionModelType {
    
    init(original: SectionDataSources<Element>, items: [Element]) {
        self = original
        self.items = items
    }
    
}
