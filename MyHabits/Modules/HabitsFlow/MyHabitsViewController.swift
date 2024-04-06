
import UIKit

final class MyHabitsViewController: UIViewController, UpdateCollectionProtocol {
    
    private lazy var habitStore: HabitsStore = HabitsStore.shared
    
    //MARK: - View
    
    private lazy var habitsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .ligthGray2//UIColor.lightGray
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
    
    private lazy var todayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Сегодня"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    //MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .grayHeader
        onCollectionUpdate()
        setupLayout()
        navigationController?.navigationBar.isHidden = true
    }
    
    //MARK: - Config view
    
    func onCollectionUpdate() {
        habitsCollectionView.reloadData()
    }
}
//MARK: - Extention

private extension MyHabitsViewController {
    
    func setupLayout() {
        view.addSubview(habitsCollectionView)
        view.addSubview(todayLabel)
        view.addSubview(addButton)

        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8),
            addButton.heightAnchor.constraint(equalToConstant: 30),
            addButton.widthAnchor.constraint(equalToConstant: 30),
            
            habitsCollectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            habitsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            habitsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            habitsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            todayLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            todayLabel.bottomAnchor.constraint(equalTo: habitsCollectionView.topAnchor, constant: -8)
        ])
    }
    
    //MARK: - Action
    
    @objc func tapAddButton() {
        let viewController = CreateHabitsViewController()
        viewController.updateCollectionCallback = self
        viewController.modalPresentationStyle = .fullScreen
        viewController.modalTransitionStyle = .coverVertical
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }
    
}

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
