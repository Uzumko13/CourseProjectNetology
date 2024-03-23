

import UIKit

class CreateHabitsViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ligthGray2
        setupNavigationBar()
    }

}
    //MARK: - Extention
    
    private extension CreateHabitsViewController {
        
        //MARK: - Config view
        
        func addSubview() {
            
        }
        func setupNavigationBar() {
            self.navigationController?.navigationBar.barTintColor = UIColor(named: "GrayHeader")
            self.navigationController?.navigationBar.prefersLargeTitles = true
            navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "PurpleHabits")
            navigationItem.title = "Создать"
        }

    }
