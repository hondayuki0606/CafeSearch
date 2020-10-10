//
//  ViewController.swift
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/04.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let URL_SAVE_BOY = "http://10.207.171.16:8081/laravelapp/public/input_do.php"
    
    @IBOutlet weak var imageView: UIImageView!
    //UITextField Set Propaties
    @IBOutlet weak var userId: UITextField!
    //Button　action Method
    @IBOutlet weak var commentFeild: UITextField!
    @IBOutlet weak var hashBtn: UIButton!
    @IBOutlet weak var friendBtn: UIButton!
    
    @IBAction func hashBtn(_ sender: UIButton) {
        var comments = comment.text!
        comments.append("#")
        comment.text = comments
    }
    
    @IBOutlet weak var comment: UITextView!
    @IBAction func friendBtn(_ sender: UIButton) {
        var comments = comment.text!
        comments.append("@")
        comment.text = comments
    }
    
    @IBOutlet weak var uploadBtn: UIButton!
    @IBAction func upload(_ sender: Any) {
        
        let alertController = UIAlertController(title: "アップロード",message: "画像アップロード処理を実行してもよろしいでしょうか？", preferredStyle: UIAlertController.Style.alert)
        
        // OKボタンの実装
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            // TextFieldから文字を取得
            //textFieldString = textField.text!
            let comments = self.commentFeild.text!
            // ハッシュ情報作成
            let hashArray = comments.split(separator: "#")
            var hashData = ""
            let hashTag = "#"
            for hash in hashArray{
                hashData = String(format: "%@%@,",hashTag,hash as CVarArg)
            }
            let formatHashData = hashData.dropLast()
            
            // フレンド情報作成
            let friendArray = comments.split(separator: "@")
            var friendData = ""
            let friendTag = "@"
            for friend in friendArray{
                friendData = String(format: "%@%@,",friendTag,friend as CVarArg)
            }
            let friendHashData = friendData.dropLast()
            
            // OKがクリックされた時の処理
            let client = APIClient()
            let parameters:[String: Any]  = ["user_id": "hondayuki0606",
                                             "lat": 23.77,
                                             "lot": 99.222,
                                             "comment":  comments,
                                             "hash_tag": formatHashData,
                                             "user_tag": friendHashData,
                                             "image": self.imageView.image!]
            // サーバー処理実施
            client.multipartPost(urlString: self.URL_SAVE_BOY, parameters: parameters)
            
        }
        
        // CANCELボタンの実装
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        // アップロードボタンの追加
        alertController.addAction(okAction)
        // CANCELボタンの追加
        alertController.addAction(cancelButton)
        // アラートの表示
        present(alertController,animated: true,completion: nil)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
