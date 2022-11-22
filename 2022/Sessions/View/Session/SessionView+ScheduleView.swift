//
//  SessionView+ScheduleView.swift
//  LetSwift
//
//  Created by 강경훈 on 2022/11/08.
//

import SwiftUI

extension SessionView {
    struct ScheduleView: View {
        @State private var sessionInformations: [SessionInformationModel] = []
        @State private var clickedPlaceType: PlaceType = .bigRoom
        
        var body: some View {
            VStack(alignment: .leading, spacing: .zero) {
                Text("Schedule")
                    .font(.title3Bold)
                    .foregroundColor(.white)
                
                HStack(spacing: 20) {
                    ForEach(PlaceType.allCases) { placeType in
                        placeType.buttonView(isClicked: placeType == self.clickedPlaceType)
                            .onTapGesture {
                                self.clickedPlaceType = placeType
                            }
                    }
                    
                    Spacer()
                }
                .padding(.top, 25)
                
                VStack(spacing: 20) {
                    ForEach(self.selectedPlaceTypeOfSessionInformations) { information in
                        VStack(alignment: .leading, spacing: 20) {
                            RowView(sessionInformation: information)
                                .padding(.bottom, self.isLastModel(of: information) ? 50 : 0)
                            
                            if !self.isLastModel(of: information) {
                                SessionView.DividerView(height: 1, color: .backgroundWhite.opacity(0.3))
                            }
                        }
                    }
                }
                .padding(.top, 30)
            }
            .onAppear {
                self.setSessionInformations()
            }
        }
        
        private var selectedPlaceTypeOfSessionInformations: [SessionInformationModel] {
            let selectedPlaceTypeOfSessionInformation = self.sessionInformations.filter { information in
              information.placeTypeString == self.clickedPlaceType.rawValue
            }
            return selectedPlaceTypeOfSessionInformation
        }
        
        private func isLastModel(of information: SessionInformationModel) -> Bool {
            return information == self.selectedPlaceTypeOfSessionInformations.last
        }
    }
}

extension SessionView.ScheduleView {
    private func setSessionInformations() {
        APICaller.shared.getSessionData { result in
            switch result {
            case .success(let sessionInformationsAPIResponse):
                self.sessionInformations = sessionInformationsAPIResponse
            case .failure(let error):
                print("error", error)
            }
        }
    }
}
