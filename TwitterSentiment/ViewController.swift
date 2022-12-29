//
//  ViewController.swift
//  TwitterSentiment
//
//  Created by Tanaka Mawoyo on 29.12.22.
//

import UIKit
import SwifteriOS
import CoreML

class ViewController: UIViewController {

   
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier  = TweetSentimentClassifier()
    
    
    let swifter = Swifter(consumerKey: "3to6tX5wYylR9SdZEfELHUDRK", consumerSecret: "d6OXwc9buSqngWWD8ej38FTxO7VFs89agNi9dFjj17Ck5eERpN")
    
    

    
    override func viewDidLoad() {
           super.viewDidLoad()
           // Do any additional setup after loading the view.
        
        let prediction = try! sentimentClassifier.prediction(text: "@Apple is a great company")
        
        print(prediction.label)
        
        
        swifter.searchTweet(using: "@Apple", lang: "en", count: 100, tweetMode: .extended ) { (results, metadata) in
           // print(results)
        } failure: { error in
            print("there was an error with the Twitter API Request, \(error)")
        }
        

       }
    
    @IBAction func predictPressed(_ sender: Any) {
        
        
    }
    
}

