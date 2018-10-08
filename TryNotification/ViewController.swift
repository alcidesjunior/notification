//
//  ViewController.swift
//  TryNotification
//
//  Created by Alcides Junior on 08/10/18.
//  Copyright © 2018 Alcides Junior. All rights reserved.
//

import UIKit
import UserNotifications
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        UNUserNotificationCenter.current().delegate = self
        scheduleNotifications()
    }
    func scheduleNotifications(){
        let content = UNMutableNotificationContent()
        let requestIdentifier = "notificationID"
        
        content.badge = 1
        content.title = "Estudar bateria!"
        content.subtitle = "Quem estuda, fica bom"
        content.body = "Estudar pra ficar monstro igual o Colaiuta..."
        content.sound = UNNotificationSound.default
        
        let url = Bundle.main.url(forResource: "colaiuta", withExtension: ".jpg")
        do{
            let attachment = try? UNNotificationAttachment(identifier: requestIdentifier, url: url!, options: nil)
            content.attachments = [attachment!]
        }
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 2.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error: Error?) in
            if error != nil{
                print(error?.localizedDescription)
            }
            print("deu bom")
        }
    }


}
extension ViewController: UNUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound,.badge])
    }
}

