
import UIKit

final class DetailsHabitsViewController: UIViewController, HabitDetailsViewProtocol {
    
    //MARK: - Properties
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var habitDates: [Date] = {
        HabitsStore.shared.dates.reversed()
    }()
    
    private lazy var imageView: UIImageView? = {
        let imageView = UIImageView(image: UIImage.init(systemName: "checkmark"))
        imageView.tintColor = .purpleHabits
        
        return imageView
    }()
    
    private lazy var habitTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DetailsHabitsTableViewCell.self, forCellReuseIdentifier: DetailsHabitsTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.doesRelativeDateFormatting = true
        return formatter
    }()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = false
        setupLayout()
    }
    
}

    //MARK: - Extention

private extension DetailsHabitsViewController {
    
    func setupLayout() {
        navigationController?.navigationBar.tintColor = .purpleHabits
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Править",
            style: .done,
            target: self,
            action: #selector(createButtonPressed)
        )
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "Сегодня", style: .done, target: nil, action: nil)
        navigationItem.title = habit.name

        
        view.addSubview(habitTableView)
        NSLayoutConstraint.activate([
            habitTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            habitTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            habitTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            habitTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    //MARK: - Action
    
    @objc func createButtonPressed(_ sender: Any) {
        let vc = CreateHabitsViewController()
        vc.habit = habit
        vc.habitEditionState = .edition
        vc.nameTextField.text = habit.name
        vc.colorPickerView.backgroundColor = habit.color
        vc.datepicker.date = habit.date
        vc.nameTextField.textColor = habit.color
        vc.habitDetailsViewCallback = self
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        navigationController?.present(vc, animated: true, completion: nil)
    }
}

extension DetailsHabitsViewController: DetailsHabitsViewProtocol {
    func onHabitDelete() {
        navigationController?.popToRootViewController(animated: true)
    }
    func onHabitUpdate(habit: Habit) {
        self.habit = habit
        navigationItem.title = habit.name
    }
}

extension DetailsHabitsViewController: UITableViewDelegate {
}

extension DetailsHabitsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HabitsStore.shared.dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: DetailsHabitsTableViewCell.reuseID,
            for: indexPath
        ) as! DetailsHabitsTableViewCell
        
        cell.textLabel?.text = dateFormatter.string(from: habitDates[indexPath.row])
        if HabitsStore.shared.habit(habit, isTrackedIn: habitDates[indexPath.row]) {
            cell.accessoryView = imageView
            cell.accessoryView?.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "АКТИВНОСТЬ"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
