
# SwiftMulticastProtocol
Easy way to use a multicast intefrace
<p align="center">
<img src="https://user-images.githubusercontent.com/16253548/28453311-1919a444-6df7-11e7-9ffd-e4438c01c903.png" width="400px">
</p>

[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()
[![Swift3](https://img.shields.io/badge/swift3-compatible-brightgreen.svg)]()
With this simple method you can implement a multicast interface to send a message from one class to all registered instances.

For example, to create a simple chat application, you have a UITableView with a list of chats, and you have another class called ChatActivity with a UICollectionView of messages. Both class want to know when new message has been received or delivered. First class to show a badge count, second class to show bubble message.  First of all you have to create your interface, for example:

```swift
import Foundation

@objc protocol MessageDelegate {
    
    ///Called when new message has been received
    func newMessageReceived(message: ChatMessage)
    ///Called when new message has been delivered
    optional func newMessageDelivered(messagge: ChatMessage)

}
```

To be able to have a multiple connection to this protocol, create a multicast delegate like this:

```swift
class MessageDelegateMulticast {
    
    private var notifiers: [MessageDelegate] = []
    
    func newMessageReceived(message: ChatMessages){
        notifyAll { notifier in
            notifier.newMessageReceived(message)
        }
    }
    func newMessageDelivered(message: ChatMessages){
        notifyAll { notifier in
            if(notifier.newMessageDelivered != nil){
                notifier.newMessageDelivered!(message)
            }
        }
    }
    
    func addNotifier(notifier: MessageDelegate) {
        removeNotifier(notifier)
        notifiers.append(notifier)
    }
    
    func removeNotifier(notifier: MessageDelegate) {
        for i in 0 ..< notifiers.count {
            if notifiers[i] === notifier || object_getClassName(notifiers[i]) ==  object_getClassName(notifier) {
                notifiers.removeAtIndex(i)
                break;
            }
        }
    }
    
    private func notifyAll(notify: MessageDelegate -> ()) {
        for notifier in notifiers {
            notify(notifier)
        }
    }
    
}
```

## USAGE

In a singelton class create an instance of multicast in like this:

```swift
class AppCore:NSObject{
  
  ...
  
  var messageDelegate:MessageDelegateMulticast = MessageDelegateMulticast()
  
  ...
  
}
let sharedAppCore = AppCore()
```

Each class, to receive the message can subscribe to a delegate:

```swift
class ClientA:MessageDelegate{
  
  override func viewDidLoad() {
    sharedAppCore.messageDelegate.addNotifier(self)
  }
  
  override func viewDidDisappear(animated: Bool) {
    sharedAppCore.messageDelegate.removeNotifier(self)
  }
  
  //MARK
  func newMessageReceived(message: ChatMessage){
    print("New message has been received")  
  }
  
  func newMessageDelivered(messagge: ChatMessage){
    print("New message has been sent")  
  }
  
}

class ClientB:MessageDelegate{
  
  override func viewDidLoad() {
    sharedAppCore.messageDelegate.addNotifier(self)
  }
  
  override func viewDidDisappear(animated: Bool) {
    sharedAppCore.messageDelegate.removeNotifier(self)
  }
  
  //MARK
  func newMessageReceived(message: ChatMessage){
    print("New message has been received")  
  }
  
  func newMessageDelivered(messagge: ChatMessage){
    print("New message has been sent")  
  }
  
}
```

Now when method of delegate is called like this:

```swift
sharedAppCore.messageDelegate.newMessageReceived(message)
```

ClassA and ClassB will be informed and will receive the message.

## Projects using SwiftMulticastProtocol

- Frind - [www.frind.it](https://www.frind.it) 

### Your App and SwiftMulticastProtocol
I'm interested in making a list of all projects which use this library. Feel free to open an Issue on GitHub with the name and links of your project; we'll add it to this site.

## Credits & License
SwiftMulticastProtocol is owned and maintained by [Luca Becchetti](https://github.com/lucabecchetti) 

As open source creation any help is welcome!

The code of this library is is free to use and change (I'm happy to discuss any PR with you)

## About me

I am a professional programmer with a background in software design and development, currently developing my qualitative skills on a startup company named "[Frind](https://www.frind.it) " as Project Manager and ios senior software engineer.

I'm high skilled in Software Design (10+ years of experience), i have been worked since i was young as webmaster, and i'm a senior Php developer. In the last years i have been worked hard with mobile application programming, Swift for ios world, and Java for Android world.

I'm an expert mobile developer and architect with several years of experience of team managing, design and development on all the major mobile platforms: iOS, Android (3+ years of experience).

I'm also has broad experience on Web design and development both on client and server side and API /Networking design. 

All my last works are hosted on AWS Amazon cloud, i'm able to configure a netowrk, with Unix servers. For my last works i configured apache2, ssl, ejabberd in cluster mode, Api servers with load balancer, and more.

I live in Assisi (Perugia), a small town in Italy, for any question, [contact me](mailto:luca.becchetti@brokenice.it)
