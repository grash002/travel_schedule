//
//  ListOfCarriesRowView.swift
//  travel_schedule
//
//  Created by Иван Иван on 07.05.2025.
//

import SwiftUI
import SDWebImageSwiftUI

struct ListOfTripsRowView: View {
    let trip: Trip
    let viewModel: ListOfTripsViewModel
    
    var formatterDayMonth: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM"
        formatter.timeZone = TimeZone(secondsFromGMT: 3 * 3600)
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }
    var formatterTime: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.timeZone = TimeZone(secondsFromGMT: 3 * 3600)
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 18)  {
            HStack(spacing: 8) {
                WebImage(url: URL(string: trip.logoSVG))
                    .resizable()
                    .frame(width: 38, height: 38)
                    .cornerRadius(12)
                VStack(alignment: .leading,spacing: 2) {
                    Text(trip.carrierTitle)
                        .foregroundStyle(.black)
                        .font(.system(size: 17))
                    if let transfer = trip.transfer,
                       transfer {
                        Text("С пересадкой")
                            .font(.system(size: 12))
                            .foregroundStyle(.red)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(formatterDayMonth.string(from: trip.date))
                    .font(.system(size: 12))
                    .foregroundStyle(Color.black)
            }
            HStack(spacing: 4) {
                Text(formatterTime.string(from: trip.startTime))
                    .foregroundStyle(.black)
                    .font(.system(size: 17))
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text(viewModel.durationToString(trip.duration))
                    .font(.system(size: 12))
                    .foregroundStyle(Color.black)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                Text(formatterTime.string(from: trip.endTime))
                    .font(.system(size: 17))
                    .foregroundStyle(Color.black)
            }
        }
        .padding(14)
        .background(Color.lightGrayBackground)
        .cornerRadius(14)
    }
}

#Preview {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
    return ListOfTripsRowView(trip:  Trip( logoSVG: "https://yastat.net/s3/rasp/media/data/company/svg/R-30x30__opt.svg",
                                           date: formatter.date(from: "2014/01/01 00:00:00")!,
                                           startTime: formatter.date(from: "2014/01/01 01:15:00")!,
                                           endTime: formatter.date(from: "2014/01/01 09:00:00")!,
                                           duration: 5100,
                                           carrierTitle: "РЖД",
                                           transfer: true,
                                           carrier: Carrier(name: "", imageURL: URL(string: "")!, email: "", phone: "")),
                              viewModel: ListOfTripsViewModel(departurePoint: Station(name: "", code: ""), arrivalPoint: Station(name: "", code: "")
                                                                                                             )
    )
}
