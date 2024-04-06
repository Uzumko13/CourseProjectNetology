//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Иван Беляев on 22.03.2024.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Все получится!"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor.systemGray2
        
        return label
    }()
    
    private var habitSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.setThumbImage(UIImage(), for: .normal)
        slider.setValue(HabitsStore.shared.todayProgress, animated: true)
        slider.tintColor = UIColor.purpleHabits
        
        return slider
    }()
    
    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = UIColor.systemGray
        label.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
        
        return label
    }()
    
    func show() {
        habitSlider.setValue(HabitsStore.shared.todayProgress, animated: true)
        statusLabel.text = String(Int(HabitsStore.shared.todayProgress * 100)) + "%"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }
    
    private func setupLayout() {
        contentView.roundCornerWithRadius(4, top: true, bottom: true, shadowEnabled: false)
        contentView.backgroundColor = .white
        contentView.addSubview(nameLabel)
        contentView.addSubview(habitSlider)
        contentView.addSubview(statusLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            
            habitSlider.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            habitSlider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            habitSlider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            habitSlider.heightAnchor.constraint(equalToConstant: 7),
            habitSlider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: habitSlider.trailingAnchor)
        ])
    }
}

