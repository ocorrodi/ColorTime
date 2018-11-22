//
//  AlarmViewController.swift
//  ColorTime
//
//  Created by Victoria Corrodi on 8/4/17.
//  Copyright © 2017 Olivia Corrodi. All rights reserved.
//

//
//  AlarmViewController.swift
//  ColorTime
//
//  Created by Emily Erlichson on 5/27/17.
//  Copyright © 2017 Emily Erlichson. All rights reserved.
//

import UIKit

class AlarmViewController: UIViewController, UITextFieldDelegate {
    var alarmSaver = [String() : Date()]
    @IBOutlet weak var timePicker: UIDatePicker!
    var isOn = false
    var status = [Bool()]
    var notifications = [UILocalNotification()]
    @IBAction func goBack(_ sender: Any) {
//        //save
//        let date = timePicker.date
//        //var alarmSaver = UserDefaults.standard.array(forKey: "alarms") as? [Date] ?? [Date]()
//        alarmSaver.insert(date, at : 0)
//        UserDefaults.standard.set(alarmSaver, forKey: "alarms")
//        self.dismiss(animated: true, completion: nil)
        
    }
    @IBOutlet weak var alarmTitleTextField: UITextField!
    
    var onDataAvailable : ((_ data: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timePicker.datePickerMode = UIDatePickerMode.time
        timePicker.addTarget(self, action: #selector(dateTimeChanged), for: .valueChanged);
        if UserDefaults.standard.dictionary(forKey: "alarms") != nil {
            alarmSaver = UserDefaults.standard.dictionary(forKey: "alarms") as! [String:Date]
        }
        else {
            alarmSaver = [String() : Date()]
        }
        if UserDefaults.standard.array(forKey: "status") != nil {
            status = UserDefaults.standard.array(forKey: "status") as! [Bool]
        }
        else {
            status = [Bool()]
        }
        if UserDefaults.standard.array(forKey: "notifications") != nil {
            notifications = UserDefaults.standard.array(forKey: "notifications") as! [UILocalNotification]
        }
        else {
            notifications = [UILocalNotification()]
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindToAlarms" {
            var date = timePicker.date
            let currentTime = Calendar.current.date(from: DateComponents())
            while date.compare(currentTime!) == .orderedAscending {
                date.addTimeInterval(86400.0)
            }
            if UserDefaults.standard.dictionary(forKey: "alarms") != nil {
                alarmSaver = (UserDefaults.standard.dictionary(forKey: "alarms") as? [String:Date])!
            }
            else {
                alarmSaver = [:]
            }
            if UserDefaults.standard.array(forKey: "status") != nil {
                status = UserDefaults.standard.array(forKey: "status") as! [Bool]
            }
            else {
                status = []
            }
            if UserDefaults.standard.array(forKey: "notifications") != nil {
                notifications = UserDefaults.standard.array(forKey: "notifications") as! [UILocalNotification]
            }
            else {
                notifications = [UILocalNotification()]
            }
            let text = alarmTitleTextField.text
            alarmSaver[text!] = date
            status.append(true)
            UserDefaults.standard.set(status, forKey: "status")
            UserDefaults.standard.set(alarmSaver, forKey: "alarms")
            let notification = UILocalNotification()
            notification.alertBody = text
            notification.fireDate = date
            notification.soundName = "Alarm-Clock Sound!!!.mp3"
            //notification.timeZone =
            notifications.append(notification)
            //UserDefaults.standard.set(notifications, forKey: "notifications")
            UIApplication.shared.scheduleLocalNotification(notification)
            self.dismiss(animated: true, completion: nil)

            let VC = segue.destination as! EditClocksViewController
            VC.alarmSaver = self.alarmSaver
        }
    }
    
    func sendData(data: String) {
        self.onDataAvailable?(data)
      }
    
    
    func dateTimeChanged(picker: UIDatePicker) {
        let df = DateFormatter();
        df.dateFormat = "h:mm a";
        let yourDateTime = df.string(from: timePicker.date)
        sendData(data: yourDateTime)
        let date = timePicker.date
//        var alarmSaver = UserDefaults.standard.array(forKey: "alarms") as? [Date] ?? [Date]()
//        alarmSaver.insert(date, at : 0)
//        UserDefaults.standard.set(alarmSaver, forKey: "alarms")
        
        
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "lmao" {
//            print("segueing back")
//            let ecvc = segue.destination as! EditClocksViewController
//            ecvc.alarmSaver = [timePicker.date]
//        }
//    
//    }
}
