//
//  MessageDelegate.swift
//  SwiftMulticastProtocol
//
//  Created by Luca Becchetti on 21/07/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//

import Foundation

/// Custom type, edit as you need
typealias ChatMessage = String


/// Delegate to implement in all classes
@objc protocol MessageDelegate {
    
    ///Called when new message has been received
    func newMessageReceived(message: ChatMessage)
    
}


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
