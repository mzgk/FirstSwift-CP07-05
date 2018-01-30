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
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - プロパティ
    var photos: [PHAsset] = []      // 取得した写真情報（画像は格納されない）
    let manager = PHImageManager()  // 画像取得するためのインスタンス

    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        collectionView.dataSource = self
        collectionView.delegate = self

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
        return photos.count
    }

    // 対象のインデックスに対応するセルのインスタンス
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // セルを生成（StoryBoardから"ImageCell"とIdentifierで定義したUICollectionViewCellが探し出され生成される）
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath)
        // そのセルに対応するPHAssetインスタンスをphotosプロパティから取得する
        let asset = photos[indexPath.item]
        // 写真情報から画像を取得する際のサイズを作成
        let width = collectionView.bounds.size.width
        // PHAssetインスタンスから画像を取得する
        manager.requestImage(
            for: asset,     // 対象のPHAssetインスタンス
            targetSize: CGSize(width: width, height: width),
            contentMode: .aspectFit,   // アスペクト比を保ったまま、指定サイズに収まるように
            options: nil,
            resultHandler: { result, info in    // 画像の取得が終わったら呼び出される（引数２・戻り値なしのクロージャ構文）
                // result : 取得できた画像イメージ（オプショナル）
                if let image = result { // if-let文でアンラップ
                    // セル内から指定したTagのインスタンスを取得　→　UIView?インスタンスが返るが、UIImageViewであることは明確なのでダウンキャスト
                    let imageView = cell.viewWithTag(1) as! UIImageView
                    // 上記で取得したように、imageViewにはセル内に配置したUIImageViewのインスタンスが格納されている
                    imageView.image = image
                }
        })
        return cell
    }

    // MARK: - デリゲート：UICollectionViewDelegateFlowLayout
    // セルのサイズ（今回は幅３等分での正方形で表示）
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 横３列なので、collectionViewを３等分
        let width = collectionView.bounds.size.width / 3
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
    /// 写真を取得する（呼び出し元がユーザー許可のハンドラ関数　→　非同期処理内）
    func loadPhotos() {
        // 写真データを取得する（メディア：画像、オプション：なし、戻り値はPHFetchResultインスタンスの配列）
        let result = PHAsset.fetchAssets(with: .image, options: nil)
        // 写真を取り出すために必要なIndexSet構造体を作成する（０〜写真数 - 1の範囲）
        let indexSet = IndexSet(integersIn: 0..<result.count)
        // 写真データの配列を取得する
        let loadPhotos = result.objects(at: indexSet)
        photos = loadPhotos
        // 非同期処理の中（呼び出し元がユーザ許可のハンドラ関数内）で、UIを操作するのでDispatchQueue.mainをを使用する　→　UIへの反映を即時に行うため
        DispatchQueue.main.sync {
            collectionView.reloadData()
        }
    }
}

