//
//  HabitsViewController.swift
//  MyHabits
//
//  Created by Иван Беляев on 18.03.2024.
//

import UIKit

class HabitsViewController: UIViewController {
    
    //MARK: - View
    private let scrollViewHabits = UIScrollView()
    private let contentViewHabits = UIView()
    private var habitTableView = UITableView()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LigthGray2")
        setupNavigationBar()
    }
}

//MARK: - Extention

private extension HabitsViewController {
    
    //MARK: - Config view
    
    func addSubview() {
        
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "GrayHeader")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .append, style: .plain, target: self, action: #selector(buttonPressed))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "PurpleHabits")
        navigationItem.title = "Сегодня"
    }
    
    //MARK: - Action
    
    @objc func buttonPressed() {
        let createHabitView = HabitDetailsViewController()
        navigationController?.pushViewController((createHabitView), animated: true)
    }
}
