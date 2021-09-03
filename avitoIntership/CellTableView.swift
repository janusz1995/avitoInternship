//
//  CellTableViewTableViewCell.swift
//  avitoIntership
//
//  Created by Janusz on 9/1/21.
//

import UIKit
import SnapKit

class CellTableView: UITableViewCell {

    private let nameLabel: UILabel = {
        let label = UILabel()

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
    }

    func setupCell(name: String) {
        self.contentView.addSubview(nameLabel)
        self.contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        setupNameLabel(name)
    }

    private func setupNameLabel(_ name: String) {
        nameLabel.text = name
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.centerX.centerY.equalTo(self.contentView.center)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoder not created")
    }

}
