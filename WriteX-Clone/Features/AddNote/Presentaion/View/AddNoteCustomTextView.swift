//
//  AddNoteCustomTextView.swift
//  WriteX-Clone
//
//  Created by Ahmed Fathy on 19/06/2022.
//

import Foundation
import UIKit

//MARK: - Confirm TextView
extension AddNotesVC: UITextViewDelegate {
    
    
    func configureTextView(){
        discriptionTextView.delegate        = self
        discriptionTextView.isScrollEnabled = false
        textViewDidChange(discriptionTextView)
        textViewDidBeginEditing(discriptionTextView)
        textViewDidEndEditing(discriptionTextView)

    }
    
    
    func textViewDidChange(_ textView: UITextView) {
        let size                     = CGSize(width: view.frame.width - 20, height: .infinity)
        let estimatedSize            = discriptionTextView.sizeThatFits(size)
        heightOfTextView.constant    = estimatedSize.height
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = (textView.text == "Enter Discription" && self.title == "Add Note") ?  "":"\(self.viewModel.noteBehavior.value?.discription ?? "")"
        textView.textColor = .label
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter Discription"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n"{
            textView.resignFirstResponder()
        }
        
        return true
    }
}


