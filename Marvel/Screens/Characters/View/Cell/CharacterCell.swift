//
//  CharacterCell.swift
//  Marvel
//
//  Created by Monika Saini on 10/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var poster: UIImageView!

    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }

    var cellViewModel: CharacterCellViewModel? {
        didSet {
            cancelImageLoading()

            let imageCompletionClosure = { ( imageData: NSData ) -> Void in
                
                DispatchQueue.main.async {
                    
                    UIView.animate(withDuration: 1.0, animations: {
                        self.poster.alpha = 1.0
                        self.poster?.image = UIImage(data: imageData as Data)
                        self.contentView.setNeedsDisplay()
                    })
                }
                    
            }
            nameLabel.text = cellViewModel?.name
            descriptionLabel.text = cellViewModel?.description
           cellViewModel?.download(completionHanlder: imageCompletionClosure)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        initView()
    }
    
    func initView() {
        // Cell view customization
        backgroundColor = .clear

        // Line separator full width
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancelImageLoading()
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    private func showImage(image: UIImage?) {
        cancelImageLoading()
        UIView.transition(with: self.poster,
        duration: 0.3,
        options: [.curveEaseOut, .transitionCrossDissolve],
        animations: {
            self.poster.image = image
        })
    }
    
    private func cancelImageLoading() {
        poster.alpha = 1.0
        poster.image = nil
    }
}
