//
//  CharacterDetailViewController.swift
//  Marvel
//
//  Created by Monika Saini on 11/03/22.
//  Copyright © 2022 capgemini. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    lazy var viewModel = {
        CharacterDetailViewModel()
    }()

    var characterId: Int?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.alpha = 0.0

        viewModel.getCharacterDetail(with: characterId!)

        // Reload View closure
        viewModel.reloadView = { [weak self] in
            DispatchQueue.main.async {
                let imageCompletionClosure = { ( imageData: NSData ) -> Void in
                            
                    DispatchQueue.main.async {
                                
                        UIView.animate(withDuration: 1.0, animations: {
                            self!.imageView.alpha = 1.0
                            self!.imageView?.image = UIImage(data: imageData as Data)
                            self!.view.setNeedsDisplay()
                        })
                                
                        self!.activitySpinner.stopAnimating()
                    }
                                
                }
                self!.activitySpinner.startAnimating()
                
                self!.title = self!.viewModel.characterCellViewModel!.name
                self!.titleLabel.text = self!.viewModel.characterCellViewModel!.name
                self!.descriptionLabel.text = self!.viewModel.characterCellViewModel?.description
                self!.viewModel.characterCellViewModel?.download(completionHanlder: imageCompletionClosure)
            }
        }
    }
     
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
