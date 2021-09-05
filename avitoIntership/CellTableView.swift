//
//  CellTableView.swift
//  avitoIntership
//
//  Created by Janusz on 9/1/21.
//

import UIKit
import SnapKit

class CellTableView: UITableViewCell {

    private let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .fillEqually
        return sv
    }()

    private let skillsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
    }

    func setupCell(name: String, phone: String, skills: [String]) {
        self.contentView.addSubview(stackView)
        self.contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)

        let nameLabel = BasicLabel(name, Fonts.basic.rawValue)
        let phoneLabel = BasicLabel(phone, Fonts.basic.rawValue)

        setupStackView(nameLabel, phoneLabel)
        for skill in skills {
            skillsStackView.addArrangedSubview(BasicLabel(skill, Fonts.basic.rawValue))
        }
    }

    private func setupStackView(_ nameLabel: UILabel, _ phoneLabel: UILabel) {
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(phoneLabel)
        stackView.addArrangedSubview(skillsStackView)
        stackView.snp.makeConstraints { (make) -> Void in
            make.left.right.bottom.top.equalTo(self.contentView)
        }
        
    }

    required init?(coder: NSCoder) {
        fatalError("NSCoder not created")
    }
}
