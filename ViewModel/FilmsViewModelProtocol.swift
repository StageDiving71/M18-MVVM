//
//  FilmsViewModelProtocol.swift
//  M18homework
//
//  Created by Владимир Бурлинов on 07.08.2023.
//

import Foundation

protocol FilmsViewModelProtocol {
    
    // Возвращает количество секций в таблице
    var numberOfSections: Int { get }
    // Возвращает количество строк в определённой секции
    var number0fRowsInSection: (_ section: Int) -> Int { get }
    // Возвращает текст для кнопки с действием
    var titleForActionButton: String { get }
    // Возвращает текст для определённой ячейки
    var titleForRow: ((_ index: IndexPath) -> String) { get }
    // Возвращает параметры для установки цвета ячейки
    var backgroundColorForCell: (_ index: IndexPath) -> (red: CFloat, green: CGFloat, blue: CGFloat) { get }
    // Возвращает количество секций в таблице
    var updateView: (() -> Void)? { get set }
    // Метод вызывается при нажатии на кнопку действия
    func actionButtonTapped ()
    // Метод вызывается при нажатии на ячейку
    func cellTapped(_ index: IndexPath)
}
