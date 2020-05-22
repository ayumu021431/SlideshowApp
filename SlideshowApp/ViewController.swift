//
//  ViewController.swift
//  SlideshowApp
//
//  Created by 曽良歩 on 2020/04/24.
//  Copyright © 2020 ayumu.sora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var timer_sec: Int = 0
    var timer: Timer!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backButton: UIButton! //戻る
    @IBOutlet weak var nextButton: UIButton! //進む
    @IBOutlet weak var switchButton: UIButton! //再生・停止
    //戻るボタン
    @IBAction func backButtonTap(_ sender: Any) {
        if displayImagenumber >= 1 {
            displayImagenumber -= 1
            displayimage()
        } else {
            displayImagenumber = imageNameArray.count - 1
            displayimage()
        }
    }
    @IBAction func onTapAction(_ sender: Any) {
       self.performSegue(withIdentifier: "toZoomIn", sender: nil)
        print("a")
    }
    
    // 遷移元から遷移先にデータ(画像)を渡す
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if self.timer != nil {
        self.timer.invalidate()
        }
           // segueから遷移先のResultViewControllerのインスタンスを取得する
           let zoomInViewController:ZoomViewController = segue.destination as! ZoomViewController
         // 表示している画像の番号から名前を取り出し
                let name = imageNameArray[displayImagenumber]
                // 画像を読み込み
                let image = UIImage(named: name)
                
        // 遷移先のZoomInViewControllerで宣言しているselectedImgに値を代入して渡す
                zoomInViewController.selectedImg = image
    }
        
 
    
    //再生・停止ボタン
    @IBAction func switchButtonTap(_ sender: Any) {
        // 動作中のタイマーを1つに保つために、 timer が存在しない場合だけ、タイマーを生成して動作させる
        if self.timer == nil {
            //タイマーを設定
            self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(updateTimer(_:)), userInfo: nil, repeats: true)
            // 再生・停止ボタンタップ時に進むボタン・戻るボタンのタップ非表示
            nextButton.isEnabled = false
            backButton.isEnabled = false
            // ボタンの名前を再生とする
            switchButton.setTitle("再生", for: .normal)
            // 背景色・ボタン内テキストサイズを戻す
            self.view.backgroundColor = UIColor.white
            switchButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        } else if self.timer != nil {
            //タイマーを停止
            self.timer.invalidate()
            // nil にして再び再生(nil の時にタイマー生成)
            self.timer = nil
            // 再生・停止ボタンタップ時に進むボタン・戻るボタンのタップ非表示
            nextButton.isEnabled = true
            backButton.isEnabled = true
            // ボタンの名前を再生とする
            switchButton.setTitle("再生/停止", for: .normal)
            // 背景色・ボタン内テキストサイズを戻す
            self.view.backgroundColor = UIColor.white
            switchButton.titleLabel?.font =
            UIFont.systemFont(ofSize: 15)
        }
    }
    //進むボタン
    @IBAction func nextButtonTap(_ sender: Any) {
        if displayImagenumber < imageNameArray.count - 1 {
            //表示している画像の番号を1増やす
            displayImagenumber += 1
            //表示している画像の番号を元に画像を表示する
            displayimage()
        } else {
            displayImagenumber = 0
            displayimage()
        }
    }
    //表示している画像の番号
    var displayImagenumber = 0
    let imageNameArray = ["IMG_8582.jpg","IMG_8612.jpg","IMG_8642.jpg"]
    //表示している画像を元に画像を表示する
    func displayimage() {
        // 表示している画像の番号から名前を取り出し
        let name = imageNameArray[displayImagenumber]
        
        // 画像を読み込み
        let image = UIImage(named: name)
        // Image Viewに読み込んだ画像をセット
        imageView.image = image
    }
    
    //#selectorで呼び出される関数
    @objc func updateTimer(_ timer: Timer) {
        //進むボタンの内容
        if displayImagenumber < imageNameArray.count - 1 {
            //表示している画像の番号を1つ増やす
            displayImagenumber += 1
            // 表示している画像の番号を元に画像を表示する
            displayimage()
            print(displayImagenumber)
        } else {
            displayImagenumber = 0
            displayimage()
            print(displayImagenumber)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let image = UIImage(named: "IMG_8582.jpg")
        imageView.image = image
    }
    
   
}

