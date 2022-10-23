//
//  ReviewTVCell.swift
//  EduTune
//
//  Created by Mostafizur Rahman on 23/10/22.
//

import UIKit

class ReviewTVCell: UITableViewCell {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    @IBAction func onHeartButtonTap(_ sender: Any) {
   
    }
    
    var review: Review? {
        didSet {
            userImageView.sd_setImage(with: URL(string: review?.photo ?? "" ), placeholderImage: nil)
            usernameLabel.text = review?.username
            ratingLabel.text = "\(review?.rating ?? 0)"
            subtitleLabel.text = review?.comment
            timeLabel.text = getReviewTime(review?.created_at)
            likeButton.setTitle("\(review?.like_count ?? 0)", for: .normal)
        }
    }
    
    func getReviewTime(_ dateTime: String?) -> (String?) {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let date = dateFormater.date(from: dateTime ?? "") {
            return date.timeAgoDisplay()
        }else{
            return dateTime
        }
        
    }
    
}
