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
		print(self.frame)
		let horizontalCount = floor(self.frame.width / circleSize)
		let verticalCount = floor(self.frame.height / circleSize)
		for horI in 0..<Int(horizontalCount) {
			for verI in 0..<Int(verticalCount) {
//				print("x:", horI, "y:", verI)

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

//	func getPixelColor(_ point: CGPoint) -> UIColor {
//		guard let image = UIImage(named: "testImg") else { return .clear }
//		let cgImage : CGImage = image.cgImage!
//		guard let pixelData = CGDataProvider(data: (cgImage.dataProvider?.data)!)?.data else {
//			return UIColor.clear
//		}
//		let data = CFDataGetBytePtr(pixelData)!
//		let posX = Int(point.x)
//		let posY = Int(point.y)
//		let index = Int(image.size.width) * posY + posX
//		let expectedLengthA = Int(image.size.width * image.size.height)
//		let expectedLengthRGB = 3 * expectedLengthA
//		let expectedLengthRGBA = 4 * expectedLengthA
//		let numBytes = CFDataGetLength(pixelData)
//		switch numBytes {
//		case expectedLengthA:
//			return UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(data[index])/255.0)
//		case expectedLengthRGB:
//			return UIColor(red: CGFloat(data[3*index])/255.0, green: CGFloat(data[3*index+1])/255.0, blue: CGFloat(data[3*index+2])/255.0, alpha: 1.0)
//		case expectedLengthRGBA:
//			return UIColor(red: CGFloat(data[4*index])/255.0, green: CGFloat(data[4*index+1])/255.0, blue: CGFloat(data[4*index+2])/255.0, alpha: CGFloat(data[4*index+3])/255.0)
//		default:
//			// unsupported format
//			return UIColor.clear
//		}
//	}
//}
