//
//  HomeViewModelSpec.swift
//  DoctorHQTests
//
//  Created by Glenn Von C. Posadas on 28/05/2019.
//  Copyright © 2019 Glenn Von C. Posadas. All rights reserved.
//

@testable import DoctorHQ
import Quick
import Nimble

class HomeViewModelSpec: QuickSpec {
    /// Mock class conforming to ```HomeDelegate```
    class TestHomeDelegate: NSObject, HomeDelegate {
        var showCityListWasCalled = false
        var reloadDataWasCalled = false
        
        func showCityList() {
            self.showCityListWasCalled = true
        }
        
        func reloadData() {
            self.reloadDataWasCalled = true
        }
    }
    
    override func spec() {
        describe("Tests for HomeViewModel") {
            
            var homeDelegate: TestHomeDelegate?
            var viewModel: HomeViewModel?
            
            beforeEach {
                homeDelegate = TestHomeDelegate()
                viewModel = HomeViewModel(homeController: homeDelegate)
            }
            
            context("Tests the whole viewModel.") {
                
                it("tests the select city button") {
                    
                    // Assert
                    expect(viewModel?.delegate).notTo(beNil())
                    
                    // Call the viewModel selector
                    viewModel?.selectCity()
                    
                    // Assert
                    expect {
                        homeDelegate?.showCityListWasCalled
                        }.to(equal(true))
                }
                
                it("tests the obserrvation of the viewModel to the shared data selected cities") {
                    expect {
                        LTSharedData.selectedCities.value.count
                        }.to(equal(0))
                    
                    let data = stubbedResponse("Cities")!
                    let newCities = try! JSONDecoder().decode([City].self, from: data)
                    LTSharedData.selectedCities.accept(LTSharedData.selectedCities.value + newCities)
                    
                    expect {
                        homeDelegate?.reloadDataWasCalled
                    }.to(equal(true))
                }
            }
        }
    }
}


