

import UIKit

enum HabitEditionState {
    case creation
    case edition
}

class CreateHabitsViewController: UIViewController {
    
    //MARK: Properties and Views
    
    private let horizontalInset: CGFloat = 16
    private let imageSize: CGFloat = 30
    
    var habitEditionState = HabitEditionState.creation
    
    var updateCollectionCallback: UpdateCollectionProtocol?
    
    var habitDetailsViewCallback: HabitDetailsViewProtocol?
    
    var habit = Habit(name: "Выпить стакан воды перед завтраком", date: Date(), color: .systemRed)
    
    private lazy var habitStore: HabitsStore = {
        return HabitsStore.shared
    }()
    
    lazy var datepicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.preferredDatePickerStyle = .wheels
        picker.addTarget(self, action: #selector(datePickerChanged(picker:)), for: .valueChanged)
        
        return picker
    }()
    
    @objc func datePickerChanged(picker: UIDatePicker) {
        if habitEditionState == .creation {
            habit.date = datepicker.date
        }

        habitTimeLabelTime.text = " \(dateFormatter.string(from: datepicker.date))"
    }
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "НАЗВАНИЕ"
//        label.applyFootnoteStyle()
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        textField.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        return textField
    }()
    
    private lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ЦВЕТ"
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        return label
    }()
    
    lazy var colorPickerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.roundCornerWithRadius(15, top: true, bottom: true, shadowEnabled: false)
        view.backgroundColor = habit.color
        let tapColor = UITapGestureRecognizer(target: self, action: #selector(tapColorPicker))
        view.addGestureRecognizer(tapColor)
        
        return view
    }()
    
    private lazy var colorPickerViewController: UIColorPickerViewController = {
        let colorView = UIColorPickerViewController()
        colorView.delegate = self
        return colorView
    }()
    
    @objc func tapColorPicker() {
        present(colorPickerViewController, animated: true, completion: nil)
    }
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "ВРЕМЯ"
//        label.applyFootnoteStyle()
        
        return label
    }()
    
    lazy var habitTimeLabelText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Каждый день в"
        
        return label
    }()
    
    lazy var habitTimeLabelTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = " \(dateFormatter.string(from: datepicker.date))"
        label.tintColor = .purpleHabits
        label.textColor = .purpleHabits
        
        return label
    }()
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()
    
    
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

extension CreateHabitsViewController: UIColorPickerViewControllerDelegate {
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        habit.color = colorPickerViewController.selectedColor
        
        colorPickerView.backgroundColor = colorPickerViewController.selectedColor
    }
}
