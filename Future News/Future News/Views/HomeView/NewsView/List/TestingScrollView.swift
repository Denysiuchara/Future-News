//
//  TestingScrollView.swift
//  Future News
//
//  Created by Danya Denisiuk on 15.01.2024.
//

import SwiftUI

struct TestingScrollView: View {
    // Массив цветов
    var colors: [Color] = [.red, .yellow, .green, .yellow, .orange, .purple, .brown, .indigo, .gray,
                           .pink, .red, .yellow, .green, .yellow, .orange, .purple, .brown, .indigo,
                           .gray, .pink, .red, .yellow, .green, .yellow, .orange, .purple, .brown,
                           .indigo, .gray, .pink,]

    // Состояние для отслеживания оффсета прокрутки
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        // Главный GeometryReader для измерения геометрии представления
        GeometryReader { geo in
            // ScrollViewReader для управления ScrollView программно
            ScrollViewReader { proxy in
                // Основной ZStack, включающий в себя все представления
                ZStack {
                    // Основной ScrollView для прокрутки контента
                    ScrollView {
                        // Основной VStack для вертикального расположения элементов
                        VStack {
                            // GeometryReader для измерения геометрии вложенного представления
                            GeometryReader { insiderGeo in
                                // Отправка предпочтений (оффсета) через ViewOffsetKey
                                Color
                                    .black
                                    // preference отправляет минимальное значение Y через ключ ViewOffsetKey для передачи данных вверх по иерархии представлений.
                                    .preference(
                                        key: TestingViewOffsetKey.self,
                                        value: insiderGeo
                                                    .frame(in: .named("testingScrollView"))
                                                    .minY
                                    )
                            }

                            // Ленивая сетка для отображения элементов в два столбца
                            LazyVGrid(columns: Array(repeating: GridItem(), count: 2)) {
                                ForEach(colors.indices, id: \.self) { index in
                                    
                                    // ZStack - сами элементы
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 180, height: 180)
                                            .foregroundStyle(colors[index])
                                            .opacity(0.9)
                                            .id(index) // Идентификация элемента по индексу
                                        
                                        Text(String(index))
                                    }
                                }
                            }
                            .padding(.horizontal, 8) // Добавление горизонтального отступа
                        }
                    }
                    .coordinateSpace(name: "testingScrollView") // Установка координатного пространства для ScrollView
                    
                    // Этот блок кода добавляет обработчик, который вызывается при изменении предпочтений с использованием ключа ViewOffsetKey
                    .onPreferenceChange(TestingViewOffsetKey.self) { value in
                        // Обработка изменений в предпочтениях (оффсете)
                        self.scrollOffset = min(
                            1,
                            max(0, -value / (180 * CGFloat(colors.count) / 2 - geo.size.height))
                        )
                        // Вычисление и установка значения scrollOffset
                    }

                    // Дополнительный ZStack с элементами, зависящими от оффсета прокрутки
                    ZStack {
                        ZStack(alignment: .leading) {
                            // RoundedRectangle для отображения процента прокрутки
                            RoundedRectangle(cornerRadius: 40)
                                .frame(width: 250, height: 55)
                                .foregroundStyle(.white)

                            // HStack с текстом процента и анимированным прогресс-баром
                            HStack {
                                Text("\(Int(scrollOffset * 100))%")
                                    .bold()

                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundStyle(.green)
                                    .frame(width: 150 * scrollOffset, height: 8)
                                    .animation(.easeIn, value: scrollOffset)
                            }
                            .padding(.leading, 20)
                            .opacity(scrollOffset > 0 && scrollOffset < 1 ? 1 : 0)
                        }
                        .opacity(scrollOffset > 0 ? 0.9 : 0)

                        // Кнопка для прокрутки вверх с анимацией
                        Button {
                            withAnimation(.easeInOut) {
                                proxy.scrollTo(0, anchor: .top)
                            }
                        } label: {
                            Image(systemName: "arrow.up")
                                .font(.title)
                                .bold()
                                .frame(width: 55, height: 55)
                        }
                        .offset(y: scrollOffset == 1 ? 0 : 100)
                        .animation(.easeInOut, value: scrollOffset)
                    }
                    .mask {
                        // Маска для ограничения размера элементов в зависимости от оффсета
                        RoundedRectangle(cornerRadius: 40)
                            .frame(width: scrollOffset > 0 && scrollOffset < 1 ? 250 : 55, height: 55)
                            .animation(.easeInOut, value: scrollOffset)
                    }
                    .frame(maxHeight: .infinity, alignment: .bottom) // Установка максимальной высоты
                }
            }
        }
    }
}

// Реализация PreferenceKey для отслеживания оффсета прокрутки
struct TestingViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}

#Preview {
    TestingScrollView()
}





