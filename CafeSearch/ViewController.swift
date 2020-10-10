//
//  ViewController.swift
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/04.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var recieveImage: UIImageView!
    var postImage:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    //URL to our web service
    //let URL_SAVE_BOY = "http://[Your ip Address]/MyWebService/api/createteam.php"
    
    let URL_SAVE_BOY = "http://10.207.171.16:8081/laravelapp/public/input_do.php"
    var activityIndicatorView = UIActivityIndicatorView()
    //Button　action Method
    @IBOutlet weak var NameFeild: UITextField!
    @IBOutlet weak var oldFeild: UITextField!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBAction func downloadBtn(_ sender: UIBarButtonItem) {
    
        print("test")
    }
    
    // imageを選ぶボタン
    @IBOutlet weak var liblaryBtn: UIBarButtonItem!
    @IBAction func CameraButton(_ sender: UIButton) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera

               if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
                   let picker = UIImagePickerController()
                   picker.sourceType = sourceType
                   picker.delegate = self
                   self.present(picker, animated: true)
               }
    }
    
       @IBOutlet weak var textField:UITextField!
    
    // カメラ撮影ボタン
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageView.image = image
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        self.dismiss(animated: true)

        // 次画面遷移
        let next = storyboard!.instantiateViewController(withIdentifier: "goNext") as? ViewController2
        let _ = next?.view // ** hack code **
        next?.imageView.image = image
        self.present(next!,animated: true, completion: nil)
    }
    
    @IBAction func cameraBtn(_ sender: UIBarButtonItem) {
        let sourceType:UIImagePickerController.SourceType = UIImagePickerController.SourceType.camera

        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true)

            //self.performSegue(withIdentifier: "goNext", sender: self)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
