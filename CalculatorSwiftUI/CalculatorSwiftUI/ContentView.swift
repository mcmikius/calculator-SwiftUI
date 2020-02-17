//
//  ContentView.swift
//  CalculatorSwiftUI
//
//  Created by Mykhailo Bondarenko on 17.02.2020.
//  Copyright © 2020 Mykhailo Bondarenko. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    
    case zero, one, two, three, four, five, six, seven, eight, nine, dot
    case equals, plus, minus, multiply, divide
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .dot:
            return "."
        case .equals:
            return "="
        case .minus:
            return "-"
        case .plusMinus:
            return "+/-"
        case .divide:
            return "/"
        case .multiply:
            return "X"
        case .percent:
            return "%"
        case .plus:
            return "+"
        case .ac:
            return "AC"
        }
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .dot:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return .orange
        }
    }
    
}

// Enviroment object
// Global application state
class GlobalEnviroment: ObservableObject {
    @Published var display = ""
    
    func receiveInput(calculatorButton: CalculatorButton) {
        self.display = calculatorButton.title
    }
}

struct ContentView: View {
    
    @EnvironmentObject var enviroment: GlobalEnviroment
    
    let buttons: [[CalculatorButton]] = [[.ac, .plusMinus, .percent, .divide], [.seven, .eight, .nine, .multiply], [.four, .five, .six, .minus], [.one, .two, .three, .plus], [.zero, .dot, .equals]]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                HStack {
                    Spacer()
                    Text(enviroment.display).foregroundColor(.white).font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id:\.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            CalculatorButtonView(button: button)
                        }
                    }.padding(.bottom, 12)
                }
            }.padding(.bottom)
        }
    }
    
    
    
}

struct CalculatorButtonView: View {
    var button: CalculatorButton
    @EnvironmentObject var enviroment: GlobalEnviroment
    var body: some View {
        Button(action: {
            self.enviroment.receiveInput(calculatorButton: self.button)
        }) {
            Text(button.title).font(.system(size: 32)).frame(width: self.buttonWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4).foregroundColor(.white).background(button.backgroundColor).cornerRadius(self.buttonWidth(button: button))
        }
    }
    private func buttonWidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 5 * 12) / 4 * 2.1
        } else {
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(GlobalEnviroment())
    }
}
