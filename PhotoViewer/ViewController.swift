//
//  ViewController.swift
//  PhotoViewer
//
//  Created by 水垣岳志 on 2018/01/30.
//  Copyright © 2018年 mzgkworks.com. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // MARK: - アウトレット
    @IBOutlet weak var collectionVIew: UICollectionView!

    // MARK: - ライフサイクル
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        collectionVIew.dataSource = self
        collectionVIew.delegate = self
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
}

