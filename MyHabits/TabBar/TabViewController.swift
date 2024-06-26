
import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: - Properties
    
    var habitsViewController: UINavigationController!
    var infoViewController: UINavigationController!
    
    //MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIController()
    }
    
    //MARK: - Navigation
    
    private func setupUIController() {
        
        habitsViewController = UINavigationController.init(rootViewController: MyHabitsViewController())
        infoViewController = UINavigationController.init(rootViewController: InfoViewController())
        
        self.viewControllers = [
            habitsViewController,
            infoViewController
        ]
        
        let habits = UITabBarItem(title: "Привычки",
                                  image: .habitsIcon,
                                  tag: 0)
        let info = UITabBarItem(title: "Информация",
                                image: UIImage(systemName: "info.circle.fill"),
                                tag: 1)
        habitsViewController.tabBarItem = habits
        infoViewController.tabBarItem = info
        UITabBar.appearance().tintColor = UIColor(named: "PurpleHabits")
        UITabBar.appearance().backgroundColor = UIColor(named: "GrayTabBar")
    }
}
