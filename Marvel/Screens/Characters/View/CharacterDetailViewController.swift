//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Monika Saini on 11/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    var characterCellViewModel: CharacterCellViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = characterCellViewModel?.name
        imageView.alpha = 0.0
        
        let imageCompletionClosure = { ( imageData: NSData ) -> Void in
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 1.0, animations: {
                    self.imageView.alpha = 1.0
                    self.imageView?.image = UIImage(data: imageData as Data)
                    self.view.setNeedsDisplay()
                })
                
                self.activitySpinner.stopAnimating()
                    
            }
                
        }
        activitySpinner.startAnimating()
        
        titleLabel.text = characterCellViewModel?.name
        descriptionLabel.text = characterCellViewModel?.description
            
        characterCellViewModel?.download(completionHanlder: imageCompletionClosure)
            
    }
        
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
