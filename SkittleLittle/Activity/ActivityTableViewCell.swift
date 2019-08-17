//
//  ActivityTableViewCell.swift
//  SkittleLittle
//
//  Created by Luboslav  Ivanov on 17.08.19.
//  Copyright © 2019 ApplePie. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var topMargin: NSLayoutConstraint!
    @IBOutlet weak var bottomMargin: NSLayoutConstraint!
    
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var budgetTypeLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var peopleStackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let imageViewHeight = categoryImageView.bounds.height
        categoryImageView.roundCorners(cornerRadius: imageViewHeight / 2)
        
        #warning("To be deleted")
        categoryImageView.image = UIImage.init(color: .green,
                                               size: categoryImageView.bounds.size)
    }
    
    override func prepareForReuse() {
        peopleStackView.arrangedSubviews.forEach { $0.removeFromSuperview() } 
    }

    func configure(with transaction: Transaction) {
        categoryImageView.image = transaction.category.image
        categoryTitleLabel.text = transaction.category.name
        budgetTypeLabel.text = transaction.budgetType.rawValue
        
        let priceSign = transaction.transactionType == .outcome ? "-" : ""
        priceLabel.text = "\(priceSign)\(transaction.value) BGN"
        
        transaction.people.forEach { addPersonToStackView($0) }
    }
    
    private func addPersonToStackView(_ person: Person) {
        let personImage = person.pic.rounded()
        let imageView = UIImageView(image: personImage)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 21).isActive = true
        
        peopleStackView.addArrangedSubview(imageView)
    }
}
