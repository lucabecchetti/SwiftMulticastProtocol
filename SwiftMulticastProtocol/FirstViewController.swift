//
//  FirstViewController.swift
//  SwiftMulticastProtocol
//
//  Created by Luca Becchetti on 21/07/17.
//  Copyright © 2017 Luca Becchetti. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController,MessageDelegate {

    @IBOutlet weak var label        : UILabel!
    @IBOutlet weak var textField    : UITextField!
    
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
    
    
    /// Function to send message
    ///
    /// - Parameter sender: UIButton
    @IBAction func sendMessage(_ sender: Any) {
        
        if let txt = textField.text{
            //Comunicate event to delegate
            messageDelegateMulticast.newMessageReceived(message: txt)
        }
        textField.text = ""
        textField.resignFirstResponder()
        
    }
    
    //MARK: MessageDelegate

    
    /// Called from multicast when new message has been received
    ///
    /// - Parameter message: custom type
    func newMessageReceived(message: ChatMessage) {
        
        label.textColor = UIColor.green
        label.text = "First class has received message: \(message)"
        
    }
    
}

