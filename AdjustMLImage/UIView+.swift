//
//  UIView+.swift
//  AdjustMLImage
//
//  Created by 국윤수 on 06/12/2018.
//  Copyright © 2018 국윤수. All rights reserved.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		for view in views {
			addSubview(view)
		}
	}
}
