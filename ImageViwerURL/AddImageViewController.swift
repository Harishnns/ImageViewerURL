//
//  AddImageViewController.swift
//  ImageViwerURL
//
//  Created by HARISH NOMULA on 23/07/23.
//

import UIKit

protocol AddImageViewControllerDelegate: AnyObject {
    func didSaveImage(imageModel: ImageModel)
    
}

class AddImageViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var urlTextField: UITextField!
    
     var delegate: AddImageViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
            guard let title = titleTextField.text,
                  let url = urlTextField.text else {
                return
            }
            
            let imageModel = ImageModel(title: title, url: url)
            delegate?.didSaveImage(imageModel: imageModel)
            dismiss(animated: true, completion: nil)
        }
        
        @IBAction func cancelButtonTapped(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
    }
