//LoadCountries.swift
//
//Created by Chrizzly on 30.12.20.

import SwiftUI
struct CountryInfo: Codable {
	var _id: Int?
	var iso2: String?
	var iso3: String?
	var lat: Double
	var long: Double
	var flag: String
}
struct Country: Codable, Identifiable {
	let id = UUID()
	var updated: Int
	var country: String
	var countryInfo: CountryInfo
	var cases: Double
	var todayCases: Double
	var deaths: Double
	var todayDeaths: Double
	var recovered: Double
	var todayRecovered: Double
	var active: Double
	var critical: Double
	var casesPerOneMillion: Double
	var deathsPerOneMillion: Double
	var tests: Double
	var testsPerOneMillion: Double
	var population: Double
	var continent: String
	var oneCasePerPeople: Double
	var oneDeathPerPeople: Double
	var oneTestPerPeople: Double
	var activePerOneMillion: Double
	var recoveredPerOneMillion: Double
	var criticalPerOneMillion: Double
}
func getAllCountries() -> [Country] {
	guard let url = URL(string: "https://disease.sh/v3/covid-19/countries") else {
		fatalError("URL does not exist.")
	}
	guard let data = try? Data(contentsOf: url) else {
		fatalError("Failed to load data.")
	}
	let decoder = JSONDecoder()
	var countries = [Country]()
	var flags = [Image]()
	do {
		countries = try decoder.decode([Country].self, from: data)
	} catch {
		fatalError("\(error)")
	}
//	let imageCache = NSCache<NSString, UIImage>()
//	for country in countries {
//		if let cachedFlag = imageCache.object(forKey: country.country as NSString) {
//			print("Cached: \(country.country)")
//			flags.append(Image(uiImage: cachedFlag))
//		} else {
//			print("Not cached: \(country.country)")
//			let flagUrl = URL(string: country.countryInfo.flag)!
//			let flagData = try! Data(contentsOf: flagUrl)
//			let uiImageFlag = UIImage(data: flagData)!
//			imageCache.setObject(uiImageFlag, forKey: country.country as NSString)
//			flags.append(Image(uiImage: uiImageFlag))
//		}
//	}
	for country in countries {
		flags.append(Image(country.country))
	}
	flagImages = flags
	return countries
}

var flagImages = [Image]()
