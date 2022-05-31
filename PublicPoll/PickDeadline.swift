//
//  PickDeadline.swift
//  PublicPoll
//
//  Created by 정우 on 2022/05/30.
//

import SwiftUI

struct PickDeadline: View {
    @State var selectedDate: Date = Date()
    let endingDate: Date = Calendar.current.date(from: DateComponents(year:2023)) ?? Date()
    let startingDate: Date = Date()
    
    var body: some View {
        DatePicker("", selection: $selectedDate, in: startingDate...endingDate, displayedComponents: [.date, .hourAndMinute])
            .accentColor(Color("lavender"))
            .datePickerStyle(CompactDatePickerStyle())
            .labelsHidden()
            .environment(\.locale, Locale.init(identifier: "en"))
            .transformEffect(.init(scaleX: 0.8, y: 0.8))
            
    }
}

struct PickDeadline_Previews: PreviewProvider {
    static var previews: some View {
        PickDeadline()
    }
}
