//
//  Protocols.swift
//  MyHabits
//
//  Created by Иван Беляев on 04.04.2024.
//

import UIKit

protocol UpdateCollectionProtocol {
    func onCollectionUpdate()
}

protocol HabitTapCallback {
    func onTap(position: Int)
}

protocol DetailsHabitsViewProtocol {
    func onHabitUpdate(habit: Habit)
    func onHabitDelete()
}

protocol HabitDetailsViewProtocol {
    func onHabitUpdate(habit: Habit)
    func onHabitDelete()
}
