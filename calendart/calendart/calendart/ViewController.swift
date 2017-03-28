//
//  ViewController.swift
//  calendart
//
//  Created by Good on 28/03/2017.
//  Copyright © 2017 Good. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

        @IBAction func buttonTapped(_ sender: AnyObject?) {
            SSStyles.applyNavigationBarStyles()
    //
            let annualViewController = SSCalendarAnnualViewController(events: generateEvents())
            let navigationController = UINavigationController(rootViewController: annualViewController!)
            navigationController.navigationBar.isTranslucent = false
            self.present(navigationController, animated: true, completion: nil)
        }
    //
        fileprivate func generateEvents() -> [SSEvent] {
            var events: [SSEvent] = []
            for year in 2016...2021 {
                for _ in 1...200 {
                    events.append(generateEvent(year));
                }
            }
            return events
        }
    //
        fileprivate func generateEvent(_ year: Int) -> SSEvent {
            let month = Int(arc4random_uniform(12)) + 1
            let day = Int(arc4random_uniform(28)) + 1
    //
            let event = SSEvent()
            event.startDate = SSCalendarUtils.date(withYear: year, month: month, day: day)
           event.startTime = "09:00"
            event.name = "Example Event"
            event.desc = "Details of the event"
            
            return event
        }



}

