//
//  ViewController.swift
//  PhotoViewer
//
//  Created by 水垣岳志 on 2018/01/30.
//  Copyright © 2018年 mzgkworks.com. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - アウトレット
    @IBOutlet weak var collectionVIew: UICollectionView!

    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        collectionVIew.dataSource = self
        collectionVIew.delegate = self

        // ユーザーに許可を求めるダイアログを表示。操作完了後に、引数status戻り値なしのクロージャ式で書かれた関数が実行される。
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            if status == .authorized {
                self.loadPhotos()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - デリゲート：UICollectionViewDataSource
    // セルの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // FIXME: セル数は暫定
        return 0
    }

    // 対象のインデックスに対応するセルのインスタンス
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // FIXME: セルのインスタンスは暫定
        return UICollectionViewCell()
    }

    // MARK: - デリゲート：UICollectionViewDelegateFlowLayout
    // セルのサイズ（今回は幅３等分での正方形で表示）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横３列なので、collectionViewを３等分
        let width = collectionVIew.bounds.size.width / 3
        return CGSize(width: width, height: width)
    }

    // セル同士の横マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    // セル同士の縦マージン
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    // MARK: - ファンクション
    /// 写真を取得する
    func loadPhotos() {
        // FIXME: 写真取得処理の実装
    }
}

