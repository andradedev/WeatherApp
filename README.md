# WeatherApp

```
SDKNetwork Unit Tests Coverage: **92.9%**
SDKCommon Unit Tests Coverage: **81.6%**
WeatherApp Unit Tests Coverage: **91.5%**
WeatherApp UI Tests: Not done
```

Light Mode and Dark Mode:

<img width="312" alt="Captura de Tela 2022-09-16 às 14 59 32" src="https://user-images.githubusercontent.com/41647536/190702972-db0607d8-0631-48ed-9e35-fd8c2163bba2.png"><img width="325" alt="Captura de Tela 2022-09-16 às 14 59 04" src="https://user-images.githubusercontent.com/41647536/190702997-5bb67618-7de2-4a07-b098-896d40f67972.png">




Modulirized project, utilizing Swift Package Manager for external frameworks and Cocoapods for internal modules. 

### Instalation:

clone the project and then just run:

```
> pod install
> open WeatherApp.xcworkspace
```

if you want to edit SDKNetwork:

```
> cd SDKNetwork/SDKNetwork
> pod install
> open SDKNetwork.xcworkspace
```

The SDKNetwork and SDKCommons are a custom library that I created some time ago. 
It makes easier to handle requests without having too much code to delay the build. 




## Project comments

Using a minimum version of iOS 13 to be able to code in most macs possible. 

I used SceneDelegate but I removed the root storyboard at `info.plist` to use a Coordinator instead. 

MVVM was the architecture chosen because it is clean and robust. There are more robust architectures but they would no be clean for an app this simple. 

On the only screen we have the asked data to show the current weather. We got an array from the JSON, so the viewModel will check in the array which object has the most recent. I also added a randomized form, that will not show the most recent but one at random. I did that to make it better to see the responsiveness of the app and also how it handles the image memory, using KingFisher. 

There is no persistent data because the app didn't needed it. But using UserDefaults(low amounts of data) or Core data(bigger amounts of data) to cache could be a good idea. Using Keychain without a login screen isn't needed. 

I used AutoLayout to make this screen adjustable for every iPhone. 

The observable is not implemented but it is here to show a simpler way to use reactive data besides RxSwift, because RxSwift is not simple and light to build. One thing that I value in a project is that a good code is the simplest one that achieves the goal needed. 


The `SDKCommon` is a really small framework, but it is here to show how to handle more layers of dependency. 
The `SDKNetwork` has a lot to improve, its errors treatment is limited, but it still achieve what is needed to have a clean request that is easy to maintain. Using generics is key here. 

`Coordinator` is an excellent tool, but this app wasn't big enough to show how it can improve the quality of the code. Handling screen flows, transfering data between screens, closing a intire flow are some of its benefits. 

The unit tests are testing the ViewModel and any class that handles data, that being Decimal+Extensions and Service.
The UITests are not implemented because a 3hour period to code wasnt't enough to implement some accessibility on the app an check them, but is done right it is also simple to do. 

I used Pods + SPM because i wanted to show the strength of both. So using custom frameworks with Pods helps to edit code and build it instantly. And also SPM helps a lot on third party *open source* libraries, being light to build and also have the code visible(for example, carthage does not have its code visible). using both made the project have almost no setup steps. But in a bigger project we should study to understand which one to use, avoiding using both. 

### TODO:

- Create more features to show better the data that we got

- Have a search to make the location dynamic, or even using MapKit to use the actual location of the user.

- Implement a CI on the repository to check PRs, Tests, and also some quality of life in the code using sonar.
