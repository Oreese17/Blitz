//
//  EventTableViewCell.swift
//  Blitz
//
//  Created by Femi.O on 11/6/19.
//  Copyright © 2019 Femi Orisamolu. All rights reserved.
//

/*
protocol HomeScreenDelegate {
    func showEdittingScreen()
}
*/
 
import UIKit
import SDWebImage
import FirebaseFirestore

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var descriptionBox: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var locationView: UIImageView!
    @IBOutlet weak var locationDescription: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(wtihEvent event: EventTemplate)
    {
        mainImageView.alpha = 0.25
        
        let defaultPic : UIImage = #imageLiteral(resourceName: "defaultUser")
        let earth = UIImage(named: "earth")
        
        mainImageView.sd_setImage(with: event.picture, placeholderImage: defaultPic, options: .scaleDownLargeImages, context: .none, progress: .none) { [weak self] (image, error, cacheType, url) in
            if error != nil {
                print(error!.localizedDescription)
                return // Code stops executing
            }
            else {
                if let eventLocation = event.location1 {
                    if !eventLocation.isEmpty {
                        self?.locationDescription.text = eventLocation
                        self?.locationView.image = earth
                    }
                    else {
                        self?.locationDescription.text = nil
                        self?.locationView.image = nil
                    }
                }
                // Calculations made in TimeService.swift
                self?.authorName.text = event.author
                self?.elapsedTimeLabel.text = event.createdAt?.calendarTimeSinceNow()
                let oneHourAhead = Timestamp(date: Date(timeIntervalSinceNow: 3600))
                // Make time label red if event is happening within the next one hour
                if (event.eventTime.dateValue() <= oneHourAhead.dateValue()) {
                    self?.timeLabel.textColor = #colorLiteral(red: 0.7450980392, green: 0.1568627451, blue: 0.07450980392, alpha: 1) // #BE2813
                    self?.timeLabel.highlightedTextColor = #colorLiteral(red: 0.7450980392, green: 0.1568627451, blue: 0.07450980392, alpha: 1)
                }
                else {
                    self?.timeLabel.textColor = #colorLiteral(red: 0.137254902, green: 0.168627451, blue: 0.168627451, alpha: 1) // #232B2B
                    self?.timeLabel.highlightedTextColor = #colorLiteral(red: 0.137254902, green: 0.168627451, blue: 0.168627451, alpha: 1)
                }
                self?.timeLabel.text = event.eventTime.timeDescription()
                self?.descriptionBox.text = event.description
                self?.roundProfilePic()
            }
        }
        
    }
    
    private func roundProfilePic()
    {
        self.mainImageView.layer.cornerRadius = self.mainImageView.frame.size.height / 2
        self.mainImageView.layer.masksToBounds = true
        self.mainImageView.layer.borderWidth = 0
        self.mainImageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.mainImageView.alpha = 1.0
    }
    
}
