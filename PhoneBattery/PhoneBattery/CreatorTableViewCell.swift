//
//  CreatorTableViewCell.swift
//  Copyright (c) 2015-2018 Marcel Voss
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit

class CreatorTableViewCell: UITableViewCell {
    
    let jobLabel = UILabel()
    let nameLabel = UILabel()
    let avatarImageView = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        avatarImageView.layer.cornerRadius = 50 / 2
        avatarImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        avatarImageView.contentMode = .ScaleAspectFit
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderColor = UIColor.grayColor().CGColor
        avatarImageView.layer.borderWidth = 0.25
        self.contentView.addSubview(avatarImageView)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .Left, relatedBy: .Equal, toItem: self.contentView, attribute: .Left, multiplier: 1.0, constant: 18))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1.0, constant: 50))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1.0, constant: 50))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: avatarImageView, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 0))
        
        
        nameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        nameLabel.font = UIFont.systemFontOfSize(17)
        self.contentView.addSubview(nameLabel)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .Left, relatedBy: .Equal, toItem: avatarImageView, attribute: .Right, multiplier: 1.0, constant: 15))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: nameLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: -10))
        
        jobLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        jobLabel.font = UIFont.systemFontOfSize(14)
        self.contentView.addSubview(jobLabel)
        
        self.contentView.addConstraint(NSLayoutConstraint(item: jobLabel, attribute: .Left, relatedBy: .Equal, toItem: avatarImageView, attribute: .Right, multiplier: 1.0, constant: 15))
        
        self.contentView.addConstraint(NSLayoutConstraint(item: jobLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self.contentView, attribute: .CenterY, multiplier: 1.0, constant: 10))
    
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
