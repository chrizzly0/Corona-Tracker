//ContentView.swift
//
//Created by Chrizzly on 30.12.20.

import SwiftUI

struct ContentView: View {
	@State private var allInfos = getAllInformation()
	@State private var allCountries = getAllCountries()
	@State private var lastReload = ""
    var body: some View {
		ZStack {
			Color.white
				.edgesIgnoringSafeArea(.all)
			VStack {
				ZStack {
					Color.red
						.edgesIgnoringSafeArea(.all)
						.frame(height: 100)
						.shadow(radius: 22.5)
					HStack {
						Spacer()
						Text("Corona Tracker")
							.font(.title)
							.fontWeight(.bold)
							.foregroundColor(.white)
							.shadow(color: Color.black.opacity(0.9), radius: 20)
						Spacer()
					}
				}
				.padding(.bottom)
				HStack {
				Text("Last reload: \(lastReload)")
					.font(.title3)
					.foregroundColor(.gray)
					.onAppear(perform: {
						lastReload = formatDate(Date())
					})
				Button(action: {
					allInfos = getAllInformation()
					allCountries = getAllCountries()
					lastReload = formatDate(Date())
				}, label: {
					Image(systemName: "arrow.clockwise")
						.foregroundColor(.gray)
				})
				}
				ScrollView(.horizontal) {
					HStack {
						CardView(text: "Active Cases", number: allInfos.active, color: .orange)
						CardView(text: "Recovered", number: allInfos.todayRecovered, color: .green)
							.padding()
						CardView(text: "Deaths", number: allInfos.todayDeaths, color: .red)
					}
					.padding()
				}
				Spacer()
				ScrollView(.horizontal) {
					HStack {
						ForEach(0 ..< allCountries.count, id: \.self) { element in
							ZStack {
								Color.white
								VStack {
									HStack {
										Spacer()
										flagImages[element]
											.resizable()
											.frame(width: 75, height: 40, alignment: .leading)
											.cornerRadius(10)
											.padding()
										Spacer()
									}
									Text(allCountries[element].country)
										.fontWeight(.semibold)
										.foregroundColor(.gray)
									Spacer()
									HStack {
										Text("Active: ")
											.foregroundColor(.orange)
											.fontWeight(.semibold)
										Text("\(allCountries[element].active, specifier: "%g")")
											.foregroundColor(.gray)
											.fontWeight(.semibold)
									}
									HStack {
										Text("Today: ")
											.foregroundColor(.green)
											.fontWeight(.semibold)
										Text("\(allCountries[element].todayRecovered, specifier: "%g")")
											.foregroundColor(.gray)
											.fontWeight(.bold)
									}
									HStack {
										Text("Deaths: ")
											.foregroundColor(.red)
											.fontWeight(.semibold)
										Text("\(allCountries[element].todayDeaths, specifier: "%g")")
											.foregroundColor(.gray)
											.fontWeight(.semibold)
									}
									.padding(.bottom, 7.5)
								}
							}
							.frame(width: 210, height: 175)
							.cornerRadius(13)
							.shadow(radius: 9)
							.padding(12.5)
						}
					}
					.padding(5)
				}
				.padding(.bottom, 25)
			}
		}
	}
	func formatDate(_ date: Date) -> String {
		let formatter = DateFormatter()
		formatter.dateFormat = "hh:mm"
		return formatter.string(from: date)
	}
}
struct CardView: View {
	@Environment(\.colorScheme) var colorScheme
	var text: String
	var number: Double
	var color: Color
	var body: some View {
		ZStack {
			Color.white
			VStack {
				HStack {
					Spacer()
					Text(text)
						.foregroundColor(color)
						.fontWeight(.semibold)
						.padding(.bottom, 3)
					Spacer()
				}
				Text("\(number, specifier: "%.0f")")
					.foregroundColor(.gray)
					.fontWeight(.semibold)
			}
			.shadow(radius: 17.5)
		}
		.cornerRadius(12.5)
		.frame(width: 120, height: 120)
		.shadow(radius: 9)
	}
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
