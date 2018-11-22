//
//  editClocksViewController.swift
//  ColorTime
//
//  Created by Victoria Corrodi on 8/4/17.
//  Copyright © 2017 Olivia Corrodi. All rights reserved.
//

import Foundation

import UIKit


class EditClocksViewController: UITableViewController, AlarmTableViewCellProtocol  {
    //   @available(iOS 2.0, *)
    
    
    
    
    //  UITableViewDelegate,
    //   UITextFieldDelegate
   // @IBOutlet weak var switch2: UISwitch!
    
    var alarmSaver = [String() : Date()]
    @IBOutlet weak var entry: UITextField!
    let dateFormatter = DateFormatter()
    var status = [Bool()]
    var notifications = [UILocalNotification()]
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
       
    var dates = [Date]()
    
    
    // var items: [String] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if UserDefaults.standard.dictionary(forKey: "alarms") != nil {
            alarmSaver = UserDefaults.standard.dictionary(forKey: "alarms") as! [String:Date]; do {
                tableView.reloadData()
            }
        }
        else {
            alarmSaver = [String() : Date()]
        }
        if UserDefaults.standard.array(forKey: "status") != nil {
            status = UserDefaults.standard.array(forKey: "status") as! [Bool]; do {
                tableView.reloadData()
            }
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
        var num = 0
        for alarm in alarmSaver {
            var date = alarm.value
            num += 1
            let currentTime = Calendar.current.date(from: DateComponents())
            //(alarmSaver.index(forKey: alarm.key)?.hashValue)!
            if alarm.key != "" && status[num-1] == true {
                while date.compare(currentTime!) == .orderedAscending {
                    date.addTimeInterval(86400.0)
                }
                let notification = UILocalNotification()
                let text = alarm.key
                notification.alertBody = text
                notification.fireDate = date
                notification.soundName = "Alarm-Clock Sound!!!.mp3"
                notifications.append(notification)
                //UserDefaults.standard.set(notifications, forKey: "notifications")
                //UIApplication.shared.scheduleLocalNotification(notification)
                notifications[num-1] = notification
            }
        }
        self.tableView.reloadData()
       // self.entry.delegate = self as! UITextFieldDelegate
       // self.entry.placeholder = "HH:mm:ss"
        
        dateFormatter.dateFormat = "HH:mm:ss"
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    @IBAction func unwindToEditAlarms(segue: UIStoryboardSegue) {
        
    }
    
    
    //    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //        return dates.count
    //    }
    
    //   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //        let cell = UITableViewCell()
    //        cell.textLabel?.text = dateFormatter.string(from: dates[indexPath.row])
    
    //       return cell
    //   }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if let text = textField.text {
//            let newDate = dateFormatter.date(from: text)
//            //add to array
//            if let nd = newDate {
//                dates.append(nd)
//            } else {
//                print("date not in correct format")
//            }
//            self.tableView.reloadData()
//        }
//        return true
//    }
    
    @IBAction func switchChanged(_ sender: Any) {
    }
    
    func sendRow(row: Int, isOn: Bool) {
        var date = Array(alarmSaver.values)[row]
        let currentTime = Calendar.current.date(from: DateComponents())
        if isOn == true {
            status[row] = true
            while date.compare(currentTime!) == .orderedAscending {
                date.addTimeInterval(86400.0)
            }
            let notification = UILocalNotification()
            let text = Array(alarmSaver.keys)[row]
            notification.alertBody = text
            notification.fireDate = date
            notification.soundName = "Alarm-Clock Sound!!!.mp3"
            notifications.append(notification)
            UserDefaults.standard.set(notifications, forKey: "notifications")
            UIApplication.shared.scheduleLocalNotification(notification)
            notifications[row] = notification
        }
        else {
            status[row] = false
            let notification = UILocalNotification()
            notification.fireDate = date
            notification.soundName = "Alarm-Clock Sound!!!.mp3"
            notification.alertBody = Array(alarmSaver.keys)[row]
            for notification in UIApplication.shared.scheduledLocalNotifications as! [UILocalNotification] {
                if notification.alertBody == Array(alarmSaver.keys)[row] {
                    UIApplication.shared.cancelLocalNotification(notification)
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        self.tableView.reloadData()
        super.didReceiveMemoryWarning()
        self.view.backgroundColor = UIColor.blue
        // Dispose of any resources that can be recreated.
        
    }
    //    numberOfRowsInSection section: Int) -> Int
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        var alarmSaver = UserDefaults.standard.dictionary(forKey: "alarms") as? [String:Date] ?? [String:Date]()
        status = UserDefaults.standard.array(forKey: "status") as! [Bool]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Alarm") as! AlarmTableViewCell
        let df = DateFormatter();
        df.dateFormat = "h:mm a";
        let array = Array(alarmSaver.values)
        let yourDateTime = df.string(from: array[indexPath.row])
        let date = array[indexPath.row]
        let df2 = dateFormatter
        df2.dateFormat = "h"
        let hour = Double(df2.string(from: date))
        df2.dateFormat = "m"
        let minute = Double(df2.string(from: date))
        df2.dateFormat = "s"
        let second = Double(df2.string(from: date))
        let swiftColor = UIColor(red: CGFloat(hour!/24.0), green: CGFloat(minute!/60.0), blue: CGFloat(second!/60.0), alpha: 0.75)
        if status[indexPath.row] == true {
            cell.switch1.isOn = true
        }
        else {
            cell.switch1.isOn = false
        }
        cell.backgroundColor = swiftColor
        print("\(indexPath.row) : time \(yourDateTime)")
        cell.timeDisplay.text = "\(yourDateTime)    \(Array(alarmSaver.keys)[indexPath.row])"
//        if ((cell.timeDisplay.text?.isEqual("Label")))! {
//            cell.doSomethingWithData(data: yourDateTime)
//        }
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let key = Array(alarmSaver.keys)[indexPath.row]
            alarmSaver.removeValue(forKey: key)
            status.remove(at: indexPath.row)
            UserDefaults.standard.setValue(alarmSaver, forKey: "alarms")
            self.tableView.reloadData()
        }
    }
    //
    //
    //        cell.doSomethingWithData(data: yourDateTime)
    //        return tableView
    //
    //    }
    
    //   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //       let df = DateFormatter();
    
    //      df.dateFormat = "h:mm a";
    //       let yourDateTime = df.string(from: self.alarmSaver[0])
    //   }
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //           <#code#>
    //       }
    
    
    //      func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int {
    //          var alarmSaver = UserDefaults.standard.array(forKey: "alarms") as?[Date] ?? [Date]()
    //           return alarmSaver.count;
    //      }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //var alarmSaver = UserDefaults.standard.array(forKey: "alarms") as? [Date] ?? [Date]()
        return alarmSaver.count;
    }
    
    //    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    /*      var cellArray: [UITableViewCell] = []
     for cell in cellArray {
     }
     var cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
     //    self.returnItems()
     //   cell.textLabel?.text = self.items[indexPath.row]
     return cell
     }
     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
     print("You selected cell #\(indexPath.row)")
     }
     */
    //   func returnItems() {
    //        let df = DateFormatter();
    //      df.dateFormat = "h:mm a";
    //    let yourDateTime = df.string(from: alarmSaver[alarmSaver.count])
    
    //  items[0] = yourDateTime
    //  }
}
