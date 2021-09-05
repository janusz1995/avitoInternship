//
//  BasicLabel.swift
//  avitoIntership
//
//  Created by Janusz on 9/5/21.
//

import UIKit

final class BasicLabel: UILabel {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(_ inputText: String, _ fontSize: CGFloat) {
        super.init(frame: .zero)
        configureLabel(inputText, fontSize)
    }

    private func configureLabel(_ text: String, _ fontSize: CGFloat) {
        textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textAlignment = .center
        font = .systemFont(ofSize: fontSize)
        self.text = text
        translatesAutoresizingMaskIntoConstraints = false
    }
}
