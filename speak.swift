//
//  speak.swift
//  course project
//
//  Created by Данил Ежов on 01.02.2020.
//  Copyright © 2020 Данил Ежов. All rights reserved.
//

import Foundation
import AVFoundation

class speak{
    
    func speak( _ utterance:String, lang:String){
        let utterance = AVSpeechUtterance(string: utterance)
        utterance.voice = AVSpeechSynthesisVoice(language: lang)
        let sintez = AVSpeechSynthesizer()
        sintez.speak(utterance)
    }
    init(){}
}
