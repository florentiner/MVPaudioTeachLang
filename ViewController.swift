//
//  ViewController.swift
//  course project
//
//  Created by Данил Ежов on 01.02.2020.
//  Copyright © 2020 Данил Ежов. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class ViewController: UIViewController{
    
    let synth = AVSpeechSynthesizer()
    var wor1:[String] = []
    var wor2:[String] = []
    var wor3:String = ""
    
    
    
    override func viewDidLoad() {
        
        
    }

    
    
    
    
    @IBOutlet weak var cou: UITextField!
    
    @IBOutlet weak var field: UITextField!
    
    @IBOutlet weak var field1: UITextField!
    
    @IBAction func Add(_ sender: UIButton) {
        wor1.append(field.text ?? "error")
        wor2.append(field1.text ?? "error")
        field.text = ""
        field1.text = ""
    }
    @IBAction func Delete(_ sender: UIButton) {
        wor1 = []
        wor2 = []
    }
    @IBAction func test(_ sender: UIButton) {
        
}
    @IBAction func Translate(_ sender: Any) {
        let options = TranslatorOptions(sourceLanguage: .en, targetLanguage: .ru)
        let englishGermanTranslator = NaturalLanguage.naturalLanguage().translator(options: options)
        
        let conditions = ModelDownloadConditions(
            allowsCellularAccess: false,
            allowsBackgroundDownloading: true
        )
        englishGermanTranslator.downloadModelIfNeeded(with: conditions) { error in
            guard error == nil else { return }

            // Model downloaded successfully. Okay to start translating.
        }
        englishGermanTranslator.translate(field.text!) { translatedText, error in
            guard error == nil, let translatedText = translatedText else { return }
            self.field1.text = translatedText
            // Translation succeeded.
        }
        
    }
    @IBAction func Play(_ sender: UIButton) {
        var new1 = Int(cou.text ?? "0")
        print(wor1,wor2)
        say(firs_word: multypl(words: wor1, i: new1!) , lan_firs_word: "en-US", second_word: multypl(words: wor2, i: new1!), lan_second_word: "ru-RU")
    }
    func say(firs_word:[String],lan_firs_word:String,second_word:[String],lan_second_word:String){
        if synth.isSpeaking {
            // when synth is already speaking or is in paused state

            if synth.isPaused {
                synth.continueSpeaking()
            }else {
            synth.pauseSpeaking(at: AVSpeechBoundary.immediate)
            }
        }else{
            var i = 0
            let col = firs_word.count
            while i < col {
                let utterance1 = AVSpeechUtterance(string: firs_word[i])
                let utterance2 = AVSpeechUtterance(string: second_word[i])
            utterance1.voice = AVSpeechSynthesisVoice(language: lan_firs_word)
            utterance2.voice = AVSpeechSynthesisVoice(language: lan_second_word)
            synth.speak(utterance1)
            synth.speak(utterance2)
                i+=1
            }
    }
    }
    func multypl(words:[String],i:Int)->[String]{
        let ex = words
        var new_words = words
        for _ in 1...i{
            new_words += ex
        }
        return new_words
    }
    
    
}

