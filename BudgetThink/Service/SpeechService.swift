//
//  SpeechService.swift
//  BudgetThink
//
//  Created by Muhammad Nashrullah on 13/06/20.
//  Copyright © 2020 Muhammad Nashrullah. All rights reserved.
//


import AVFoundation
import UIKit

class SpeechService{
    
    let speechSynthizer = AVSpeechSynthesizer()
    
    func say(_ phrase:String){
        
//        guard UIAccessibility.isVoiceOverRunning else {
//            return
//        }
        
        let uterrance = AVSpeechUtterance(string: phrase)
        let langCode = "language".localized
        uterrance.voice = AVSpeechSynthesisVoice(language: langCode)
        speechSynthizer.speak(uterrance)
    }
}

extension String{
    var localized : String{
        return NSLocalizedString(self, comment: "")
    }
}
