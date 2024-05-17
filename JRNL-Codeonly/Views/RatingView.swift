//
//  RatingView.swift
//  JRNL-Codeonly
//
//  Created by 박지혜 on 5/17/24.
//

import UIKit

class RatingView: UIStackView {
    private var ratingButtons: [UIButton] = []
    var rating = 0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    private let buttonSize = CGSize(width: 44, height: 44)
    private let buttonCount = 5
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    private func setupButtons() {
        self.axis = .horizontal
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview() // 버튼 지움
        }
        ratingButtons.removeAll() // 배열에서도 모두 지움
        
        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
        let highlightedStar = UIImage(systemName: "star.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        // 별표 버튼 생성
        for _ in 0..<buttonCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchDown)
            addArrangedSubview(button)
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingButton array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0 // 2번 누르면 선택 해제
        } else {
            rating = selectedRating
        }
    }
}
