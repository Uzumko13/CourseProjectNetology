
import UIKit

class DetailsHabitsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ligthGray2
        setupNavigationBarDetails()
    }
}

    //MARK: - Extention

private extension DetailsHabitsViewController {
    
    //MARK: - Config view
    
    func addSubview() {
        
    }
    
    func setupNavigationBarDetails() {
        navigationItem.title = ""
        navigationController?.navigationBar.barTintColor = UIColor(named: "GrayHeader")
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(named: "PurpleHabits")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(buttonCreate))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "PurpleHabits")
    }
    
    //MARK: - Action
    
    @objc func buttonCreate() {
        let editHabitView = HabitsViewController()
        navigationController?.pushViewController((editHabitView), animated: true)
    }
}
