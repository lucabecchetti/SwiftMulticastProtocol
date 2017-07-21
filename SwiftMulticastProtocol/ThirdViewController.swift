//
//  SecondViewController.swift
//  SwiftMulticastProtocol
//
//  Created by Luca Becchetti on 21/07/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController,MessageDelegate {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Register to delegate
        messageDelegateMulticast.addNotifier(notifier: self)
        
        if label.text == nil || label.text! == ""{
            label.textColor = UIColor.orange
            label.text = "Delegate has been subscribed"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: MessageDelegate
    
    
    /// Called from multicast when new message has been received
    ///
    /// - Parameter message: custom type
    func newMessageReceived(message: ChatMessage) {
        
        label.textColor = UIColor.green
        label.text = "Third class has received message: \(message)"
        
    }

    
}

