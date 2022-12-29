//
//  ViewController.swift
//  TwitterSentiment
//
//  Created by Tanaka Mawoyo on 29.12.22.
//

import UIKit
import SwifteriOS
import CoreML
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sentimentLabel: UILabel!
    
    let sentimentClassifier  = TweetSentimentClassifier()
    
    let swifter = Swifter(consumerKey: "3to6tX5wYylR9SdZEfELHUDRK", consumerSecret: "d6OXwc9buSqngWWD8ej38FTxO7VFs89agNi9dFjj17Ck5eERpN")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // let prediction = try! sentimentClassifier.prediction(text: "@Apple is a great company")
        
        // print(prediction.label)
        
    }
    
    @IBAction func predictPressed(_ sender: Any) {
        
        if let searchText = textField.text {
            
            swifter.searchTweet(using: searchText, lang: "en", count: 100, tweetMode: .extended ) { (results, metadata) in
                
                var tweets = [TweetSentimentClassifierInput]()
                
                for i in 0..<100{
                    if let tweet = results[i]["full_text"].string {
                        let tweetfORclassification = TweetSentimentClassifierInput(text: tweet)
                        tweets.append(tweetfORclassification)
                    }
                }
                
                do{
                    let predictions =  try self.sentimentClassifier.predictions(inputs: tweets)
                    
                    var sentimentScore = 0
                    
                    for prediction in predictions {
                        let sentiment = prediction.label
                        
                        if sentiment == "Pos" {
                            sentimentScore += 1
                        }else if sentiment == "Neg" {
                            sentimentScore -= 1
                        }
                    }
                    if sentimentScore > 20{
                        self.sentimentLabel.text = "😻"
                    }else if sentimentScore > 10{
                        self.sentimentLabel.text = "😸"
                    }else if sentimentScore > 0{
                        self.sentimentLabel.text = "😺"
                    }else if sentimentScore == 0 {
                        self.sentimentLabel.text = "😑"
                    }else if sentimentScore > -10{
                        self.sentimentLabel.text = "🫤"
                    }else if sentimentScore > -20{
                        self.sentimentLabel.text = "🙊"
                    }else{
                        self.sentimentLabel.text = "🤮"
                    }
                    
                    
                    print(sentimentScore)
                }catch{
                    print("There was an error with making a prediction")
                }
                
            } failure: { error in
                print("there was an error with the Twitter API Request, \(error)")
            }
            
        }
        
    }
    
}

