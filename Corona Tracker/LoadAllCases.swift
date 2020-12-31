//LoadAllCases.swift
//
//Created by Chrizzly on 30.12.20.

import Foundation

struct CoronaInfo: Codable, Identifiable {
	let id = UUID()
	var updated: Double
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
	var oneCasePerPeople: Double
	var oneDeathPerPeople: Double
	var oneTestPerPeople: Double
	var activePerOneMillion: Double
	var recoveredPerOneMillion: Double
	var criticalPerOneMillion: Double
	var affectedCountries: Int
}

func getAllInformation() -> CoronaInfo {
	guard let url = URL(string: "https://disease.sh/v3/covid-19/all") else {
		fatalError("URL does not exist.")
	}
	guard let data = try? Data(contentsOf: url) else {
		fatalError("Can't load data from URL.")
	}
	let decoder = JSONDecoder()
	
	guard let allCases = try? decoder.decode(CoronaInfo.self, from: data) else {
		fatalError("Failed to decode JSON.")
	}
	return allCases
}

