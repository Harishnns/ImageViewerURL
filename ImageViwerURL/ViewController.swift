//
//  ViewController.swift
//  ImageViwerURL
//
//  Created by HARISH NOMULA on 23/07/23.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pickerView: UIPickerView!
   
    let imageStore = ImageStore.shared
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            pickerView.dataSource = self
            pickerView.delegate = self
            
            imageView.image = UIImage(named: "empty_image")
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            pickerView.reloadAllComponents()
            downloadImage(atIndex: pickerView.selectedRow(inComponent: 0))
        }
    @objc func imageAdded() {
        pickerView.reloadAllComponents()
    }
        
    func downloadImage(atIndex index: Int) {
        imageStore.getImage(at: index) { imageData in
            DispatchQueue.main.async { [self] in
                if let imageData = imageData,
                   self.pickerView.selectedRow(inComponent: 0) == index {
                    self.imageView.image = UIImage(data: imageData)
                    //self.pickerView.reloadAllComponents()
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let addVC =  segue.destination as! AddImageViewController
        addVC.delegate = self
    }
    @IBAction func addImage(_ sender: Any) {
        let addImageVC = storyboard?.instantiateViewController(withIdentifier: "AddImageViewController") as! AddImageViewController
                addImageVC.delegate = self
                present(addImageVC, animated: true, completion: nil)
            }
    
      
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageStore.getImageTitles().count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titles = imageStore.getImageTitles()
                if row < titles.count {
                    return titles[row]
                }
                return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        downloadImage(atIndex: row)
    }
}

extension ViewController: AddImageViewControllerDelegate {
    
   

    func didSaveImage(imageModel: ImageModel) {
        imageStore.addImage(imageModel)
        pickerView.reloadAllComponents()
        
        let newIndex = imageStore.getImageTitles().count - 1
        pickerView.selectRow(newIndex, inComponent: 0, animated: true)
        downloadImage(atIndex: newIndex)
    }
}
