//
//  CircleStyleImageView.swift
//  AdjustMLImage
//
//  Created by 국윤수 on 08/12/2018.
//  Copyright © 2018 국윤수. All rights reserved.
//

import UIKit

import SnapKit
import Then

class CircleStyleImageView: UIImageView {

	let transferView = UIView().then {
		$0.backgroundColor = UIColor.black.withAlphaComponent(0.7)
	}

	init() {
		super.init(frame: .zero)
		self.addSubview(transferView)

		transferView.snp.makeConstraints {
			$0.edges.equalTo(self)
		}
	}

	let circleSize: CGFloat = 8
	func adjustCircleStyle() {
		guard let image = self.image else { return }
		let horizontalCount = floor(self.frame.width / circleSize)
		let verticalCount = floor(self.frame.height / circleSize)
		for horI in 0..<Int(horizontalCount) {
			for verI in 0..<Int(verticalCount) {

				let circleLayer = CALayer()
				circleLayer.cornerRadius = circleSize / 2

				let magnification = image.size.width / self.frame.size.width
				let colorPoint = CGPoint(x: CGFloat(horI) * circleSize * magnification + (circleSize / 2 * magnification),
										 y: CGFloat(verI) * circleSize * magnification + (circleSize / 2 * magnification))

				circleLayer.backgroundColor = image.getPixelColor(pos: colorPoint).cgColor

				transferView.layer.addSublayer(circleLayer)
				circleLayer.frame = CGRect(origin: CGPoint(x: CGFloat(horI) * circleSize, y: CGFloat(verI) * circleSize)
,
										   size: CGSize(width: circleSize, height: circleSize))
			}
		}

	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

}

extension UIImage {
	func getPixelColor(pos: CGPoint) -> UIColor {

		let pixelData = self.cgImage!.dataProvider!.data
		let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

		let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

		let rNum = CGFloat(data[pixelInfo]) / CGFloat(255.0)
		let gNum = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
		let bNum = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
		let aNum = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

		return UIColor(red: rNum, green: gNum, blue: bNum, alpha: aNum)
	}

}
