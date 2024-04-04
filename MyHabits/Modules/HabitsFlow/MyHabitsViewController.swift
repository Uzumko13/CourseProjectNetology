
import UIKit

protocol UpdateCollectionProtocol {
    func onCollectionUpdate()
}

class MyHabitsViewController: UIViewController, UpdateCollectionProtocol {
    
    private lazy var habitStore: HabitsStore = HabitsStore.shared
    
    //MARK: - View
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.lightGray
        collectionView.register(ProgressCollectionViewCell.self, forCellWithReuseIdentifier: ProgressCollectionViewCell.reuseID)
        collectionView.register(MyHabitsCollectionViewCell.self, forCellWithReuseIdentifier: MyHabitsCollectionViewCell.reuseID)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        return collectionView
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.sizeToFit()
        button.imageView?.tintColor = UIColor.purpleHabits
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        
        return button
    } ()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LigthGray2")
        setupNavigationBar()
    }
    
    
    //MARK: - Config view
    
    
    func onCollectionUpdate() {
        habitsCollectionView.reloadData()
    }
    func addSubview() {
        
    }
}
//MARK: - Extention

private extension MyHabitsViewController {
    
    func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor(named: "GrayHeader")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .append, style: .plain, target: self, action: #selector(tapAddButton))
        navigationItem.rightBarButtonItem?.tintColor = UIColor(named: "PurpleHabits")
        navigationItem.title = "Сегодня"
    }
    
    //MARK: - Action
    
    @objc func tapAddButton() {
        let viewController = CreateHabitsViewController()
        let updateCollectionCallback: Void = habitsCollectionView.reloadData()
        viewController.updateCollectionCallback = self
        viewController.modalTransitionStyle = .coverVertical
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
//    @objc func buttonPressed(_ sender: UIButton) {
//        let createHabitView = CreateHabitsViewController()
//        createHabitView.modalPresentationStyle = .fullScreen
//        createHabitView.modalTransitionStyle = .coverVertical
//        present(createHabitView, animated: true)
//    }
}

//MARK: - Extention

extension MyHabitsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 0) {
            return
        }
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = DetailsHabitsViewController()
        vc.habit = habitStore.habits[indexPath.item]
        navigationController?.pushViewController(vc, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return habitStore.habits.count
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let progressCell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ProgressCollectionViewCell.reuseID,
                for: indexPath
            ) as! ProgressCollectionViewCell

            progressCell.show()
            return progressCell
        } else {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MyHabitsCollectionViewCell.reuseID,
                for: indexPath
            ) as! MyHabitsCollectionViewCell

            cell.setData(habit: habitStore.habits[indexPath.item])
            cell.habitTapCallback = { [weak self] in self?.habitsCollectionView.reloadData() }

            return cell
        }
    }
}

extension MyHabitsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let height: CGFloat;
        if indexPath.section == 0 {
            height = 60
        } else {
            height = 130
        }

        return .init(width: (UIScreen.main.bounds.width - 32), height: height)
    }

    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        let top: CGFloat;
        let bottom: CGFloat;
        if section == 0 {
            top = 22
            bottom = 6
        } else {
            top = 18
            bottom = 12
        }
        return UIEdgeInsets(top: top, left: 16, bottom: bottom, right: 16)
    }
}
