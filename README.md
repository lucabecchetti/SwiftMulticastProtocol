[![Platform](https://img.shields.io/badge/platform-ios-lightgrey.svg)]()

# swiftmulticastprotocol
Easy way to use a multicast intefrace

With this simple method you can implement a multicast interface to send a message from one class to all registered instances.

For example, to create a simple chat application, you have a UITableView with a list of chats, and you have another class called ChatActivity with a UICollectionView of messages. Both class want to know when new message has been received or delivered. First class to show a badge count, second class to show bubble message.  First of all you have to create your interface, for example:

```swift
import Foundation

@objc protocol MessageDelegate:CustomDelegate {
    
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
    func newGroupMessageReceived(message: ChatMessages, eventID:String){
        notifyAll { notifier in
            if(notifier.newGroupMessageReceived != nil){
                notifier.newGroupMessageReceived!(message,eventID: eventID)
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


Author & License
-------

swiftmulticastprotocol was created and mantained by Becchetti Luca.

- Email: [luca.becchetti@brokenice.it](<mailto:luca.becchetti@brokenice.it>)
- Website: [brokenice.it](<http://www.brokenice.it>)

While swiftmulticastprotocol is free to use and change (I'm happy to discuss any PR with you)
