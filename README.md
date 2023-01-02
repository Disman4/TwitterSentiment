# TwitterSentiment

An iOS app lets a user search a username or hashtag on twitter and returns an emoji based on the overall sentiment regarding the search.
This app uses a trained CreateML model using 100 different phrases and scaling from very negative to very positive. When a search is conducted on
the app, the app uses Twitter API to retreive the 100 top recent tweets and uses the model to provide the user with an overall sentiment

## Technologies / Frameworks
- CreateML
- SwiftyJSON
- CoreML
- SwifteriOS
- Twitter API
