//
//  ViewController.swift
//  CafeSearch
//
//  Created by 本田尚行 on 2020/09/04.
//  Copyright © 2020 本田尚行. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var recieveImage: UIImageView!
    var postImage:UIImage?
    @IBOutlet weak var imageView: UIImageView!
    
    let URL_SAVE_BOY = "http://10.207.171.16:8081/laravelapp/public/input_do.php"
    var activityIndicatorView = UIActivityIndicatorView()
    //Button　action Method
    @IBOutlet weak var NameFeild: UITextField!
    @IBOutlet weak var oldFeild: UITextField!
    @IBOutlet weak var downloadBtn: UIButton!
    
    @IBAction func upload(_ sender: Any) {
        
        let alertController = UIAlertController(title: "アップロード",message: "画像アップロード処理を実行してもよろしいでしょうか？", preferredStyle: UIAlertController.Style.alert)
        
        // OKボタンの実装
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            
            // OKがクリックされた時の処理
            let client = APIClient()
            let parameters:[String: Any]  = ["user_id":  "hondayuki0606",
                                             "lat": 23.77,
                                             "lot": 99.222,
                                             "comment":  "コメント情報",
                                             "hash_tag": "#カフェ",
                                             "user_tag": "@hondayuki0606",
                                             "image":     self.imageView.image!]
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
    @IBOutlet weak var uploadBtn: UIButton!
    @IBAction func uploadBtn(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "アップロード",message: "画像アップロード処理を実行してもよろしいでしょうか？", preferredStyle: UIAlertController.Style.alert)
        
        // OKボタンの実装
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            
            // OKがクリックされた時の処理
            let client = APIClient()
            let parameters:[String: Any]  = ["user_id": "hondayuki0606", "lat": 23.77, "lot": 99.222,
                                             "comment": "コメント情報",
                                             "hash_tag": "#カフェ","user_tag": "@hondayuki0606",
                                             "image": self.imageView.image!]
            // インジケーターを表示＆アニメーション開始
            // 通信中インジケーター表示
            self.activityIndicatorView.center = self.view.center //画面中央に置く
            self.activityIndicatorView.style = .whiteLarge //スタイル設定。他に、gray,whiteが選べる
            self.activityIndicatorView.color = .gray //色設定
            self.view.addSubview(self.activityIndicatorView) //viewに追加する
            self.activityIndicatorView.startAnimating() //ローディング(くるくる)をまわす
            self.activityIndicatorView.hidesWhenStopped = true //ローディング止まった時、indicator消す(隠す)
            if self.activityIndicatorView.isAnimating { //ローディングしてるか確認
                print("ロード中")
            }
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
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBAction func saveBtn(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
