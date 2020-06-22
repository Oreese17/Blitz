//
//  MessageTemplate.swift
//  Blitz
//
//  Created by Femi.O on 5/7/20.
//  Copyright © 2020 Femi Orisamolu. All rights reserved.
//

import Foundation
import FirebaseFirestore

class MessageTemplate : NSObject {
    var message : String
    var author : String
    var photoURL : URL
    var timestamp : Timestamp
    var participants : [String : Any]? = [:] // Map representing two chat participants in no particular order
    
    
    init(author: String, message: String, profilePic: URL, timestamp: Timestamp, participants: [String : Any]?) {
        self.author = author
        self.message = message
        self.photoURL = profilePic
        self.timestamp = timestamp
        self.participants = participants
    }
    
    func getOtherID() -> String {
        guard let listOfKeys = self.participants?.keys, let currentUser = UserService.currentUserProfile else { return "" }
        let party_list = Array(listOfKeys) as [String]
        let otherID = (party_list[0] == currentUser.uid) ? party_list[1] : party_list[0]
        return otherID
    }
    
    func timeDescription() -> String
    {
        let messageTime = self.timestamp.dateValue()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        
        if calendar.isDateInToday(messageTime) { // set time for the event is the current day
            dateFormatter.dateFormat = "h:mm a"
        }
            
        else if calendar.isDateInYesterday(messageTime)
        {
            return "Yesterday" // set time for the event was yesterday
        }
            /*
        else if isSameWeek {
            let weekday = calendar.component(.weekdayOrdinal, from: messageTime)
            dateFormatter.dateFormat = calendar.weekdaySymbols[weekday] //calendar.component(.weekday, from: messageTime)
        } */
            
        else {
            dateFormatter.dateFormat = "M/d/YY"
        }
        
        // Return the string conversion of messageTime
        return dateFormatter.string(from: messageTime)
    }
}
