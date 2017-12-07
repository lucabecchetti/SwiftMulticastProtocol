
# SwiftMulticastProtocol
Easy way to use a multicast intefrace
<p align="center">
<img src="https://user-images.githubusercontent.com/16253548/28453311-1919a444-6df7-11e7-9ffd-e4438c01c903.png" width="400px">
</p>

[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![Swift3](https://img.shields.io/badge/swift3-compatible-brightgreen.svg)]()

<p align="center" >★★ <b>Star our github repository to help us!, or <a href="https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=BZD2RPBADPA6G" target="_blank"> ☕ pay me a coffee</a></b> ★★</p>
<p align="center" >Created by <a href="http://www.lucabecchetti.com">Luca Becchetti</a></p>

With this simple method you can implement a multicast interface to send a message from one class to all registered instances.

## You also may like

Do you like `SwiftMultiSelect`? I'm also working on several other opensource libraries.

Take a look here:

* **[InAppNotify](https://github.com/lucabecchetti/InAppNotify)** - Manage in app notifications
* **[CountriesViewController](https://github.com/lucabecchetti/CountriesViewController)** - Countries selection view
* **[SwiftMultiSelect](https://github.com/lucabecchetti/SwiftMultiSelect)** - Generic multi selection tableview

## Demo

![giphy](https://user-images.githubusercontent.com/16253548/28473878-b729ddf8-6e46-11e7-922c-0891a15de245.gif)

For example, to create a simple chat application, you have a UITableView with a list of chats, and you have another class called ChatActivity with a UICollectionView of messages. Both class want to know when new message has been received or delivered. First class to show a badge count, second class to show bubble message.  First of all you have to create your interface, for example:

```swift
import Foundation

/// Custom type, edit as you need
typealias ChatMessage = String

/// Delegate to implement in all classes
@objc protocol MessageDelegate {
    
    ///Called when new message has been received
    func newMessageReceived(message: ChatMessage)
    
}
```

To be able to have a multiple connection to this protocol, create a multicast delegate like this:

```swift
/// Delegate multicast
class MessageDelegateMulticast {
    
    //Array of registered classes
    private var notifiers: [MessageDelegate] = []
    
    
    /// New message received method
    ///
    /// - Parameter message: custom message type
    func newMessageReceived(message: ChatMessage){
        //Notify to all classes
        notifyAll { notifier in
            notifier.newMessageReceived(message: message)
        }
    }

    
    /// Method Register class from multicast, usually called in ViewDidLoad
    ///
    /// - Parameter notifier: class that implement MessageDelegate
    func addNotifier(notifier: MessageDelegate) {
        removeNotifier(notifier: notifier)
        notifiers.append(notifier)
    }
    
    /// Method to unregister class from multicast, usually called in ViewDidDisappear
    ///
    /// - Parameter notifier: class that implement MessageDelegate
    func removeNotifier(notifier: MessageDelegate) {
        for i in 0 ..< notifiers.count {
            if notifiers[i] === notifier || object_getClassName(notifiers[i]) ==  object_getClassName(notifier) {
                notifiers.remove(at: i)
                break;
            }
        }
    }
    
    
    /// Method that notify to all registered classes
    ///
    /// - Parameter notify: class that implement MessageDelegate
    private func notifyAll(notify: (MessageDelegate) -> ()) {
        for notifier in notifiers {
            notify(notifier)
        }
    }
    
}

/// Singleton class for multicast
let messageDelegateMulticast = MessageDelegateMulticast()
```

## USAGE
Each class, to receive the message can subscribe to a delegate:

```swift
class ClientA:MessageDelegate{
  
  override func viewDidLoad() {
    messageDelegateMulticast.addNotifier(self)
  }
  
  override func viewDidDisappear(animated: Bool) {
    messageDelegateMulticast.removeNotifier(self)
  }
  
  //MARK
  func newMessageReceived(message: ChatMessage){
    print("Message received from A: \(message)")  
  }

}

class ClientB:MessageDelegate{
  
  override func viewDidLoad() {
    messageDelegateMulticast.addNotifier(self)
  }
  
  override func viewDidDisappear(animated: Bool) {
    messageDelegateMulticast.removeNotifier(self)
  }
  
  //MARK
  func newMessageReceived(message: ChatMessage){
    print("Message received from B: \(message)")  
  }
  
}
```

Now when method of delegate is called like this:

```swift
messageDelegateMulticast.newMessageReceived(message)
```

ClassA and ClassB will be informed and will receive the message.

## Projects using SwiftMulticastProtocol

- Frind - [www.frind.it](https://www.frind.it) 

### Your App and SwiftMulticastProtocol
I'm interested in making a list of all projects which use this library. Feel free to open an Issue on GitHub with the name and links of your project; we'll add it to this site.

## Credits & License
SwiftMulticastProtocol is owned and maintained by [Luca Becchetti](http://www.lucabecchetti.com) 

As open source creation any help is welcome!

The code of this library is is free to use and change (I'm happy to discuss any PR with you)

## About me

I am a professional programmer with a background in software design and development, currently developing my qualitative skills on a startup company named "[Frind](https://www.frind.it) " as Project Manager and ios senior software engineer.

I'm high skilled in Software Design (10+ years of experience), i have been worked since i was young as webmaster, and i'm a senior Php developer. In the last years i have been worked hard with mobile application programming, Swift for ios world, and Java for Android world.

I'm an expert mobile developer and architect with several years of experience of team managing, design and development on all the major mobile platforms: iOS, Android (3+ years of experience).

I'm also has broad experience on Web design and development both on client and server side and API /Networking design. 

All my last works are hosted on AWS Amazon cloud, i'm able to configure a netowrk, with Unix servers. For my last works i configured apache2, ssl, ejabberd in cluster mode, Api servers with load balancer, and more.

I live in Assisi (Perugia), a small town in Italy, for any question, [contact me](mailto:luca.becchetti@brokenice.it)
