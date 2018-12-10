//
//  MainViewController.swift
//  AdjustMLImage
//
//  Created by 국윤수 on 06/12/2018.
//  Copyright © 2018 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

private let compressorCellID = "compressorCellID"

class MainViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()

		setupViews()
	}

	let originalImgView = UIImageView().then {
		$0.contentMode = .scaleAspectFit
		$0.image = UIImage(named: "testImg")
	}

	let imgView = CircleStyleImageView().then {
		$0.contentMode = .scaleAspectFit
		$0.image = UIImage(named: "testImg")
	}

	let compressorCV = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()).then {
		let layout = $0.collectionViewLayout as? UICollectionViewFlowLayout
		layout?.scrollDirection = .horizontal
		$0.backgroundColor = .groupTableViewBackground
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

		imgView.adjustCircleStyle()
	}
	private func setupViews() {
		title = "임프레셔"
		view.backgroundColor = .white

		view.addSubviews(originalImgView, imgView, compressorCV)

		setupLayout()
		setupCV()
	}

	private func setupLayout() {
		originalImgView.snp.makeConstraints {
			$0.top.equalTo(view.safeAreaLayoutGuide)
			$0.centerX.equalToSuperview()
			$0.size.equalTo(CGSize(width: 240, height: 160))
		}

		imgView.snp.makeConstraints {
			$0.top.equalTo(originalImgView.snp.bottom).offset(12)
			$0.centerX.equalToSuperview()
			$0.size.equalTo(CGSize(width: 240, height: 160))
		}

		compressorCV.snp.makeConstraints {
			$0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
			$0.height.equalTo(88)
		}
	}

	private func setupCV() {
		compressorCV.delegate = self
		compressorCV.dataSource = self
		compressorCV.register(UICollectionViewCell.self, forCellWithReuseIdentifier: compressorCellID)
	}
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 20
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: compressorCellID, for: indexPath)
		cell.backgroundColor = .cyan
		return cell
	}

}
