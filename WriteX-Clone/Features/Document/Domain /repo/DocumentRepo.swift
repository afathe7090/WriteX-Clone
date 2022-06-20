//
//  DocumentRepo.swift
//  WriteX
//
//  Created by Ahmed Fathy on 05/06/2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol DocumentRepo  {
    func writeNoteTORealm(_ notes: [Note])
    func readNotesFromRealm()-> [Note]?
    func returnNotesAfterInAllCaseOFFillters(_ notes: Observable<[Note]> , search: Observable<String>, isHidden: Bool) -> Observable<[Note]>
}
