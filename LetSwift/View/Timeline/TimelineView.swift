//
//  TimelineView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/04.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI
import StoreKit

struct TimelineView: View {
    
    @State var isCollapsedList = [false, true, true, true]
    @State var presentingIndex = 0 {
        didSet {
            isCollapsedList = isCollapsedList.enumerated().map {
                $0.0 != presentingIndex
            }
        }
    }
    
    // MARK: - Body
    var body: some View {
        let hourHeight: CGFloat = 240
        let spacing: CGFloat = 0
        
        return NavigationView {
            ScrollView {
                // MARK: - Legion
                TimelineLegionSection()
                
                // MARK: - Timeline
                Timetable {
                    TimeAxis(hours: 9...16, hourHeight: hourHeight, hourSpacing: spacing)
                    TimetableContainer {
                        TimelineGroup {
                            Timeline(isCollapsed: self.$isCollapsedList[0].animation()) {
                                Group {
                                    Spacer()
                                        .frame(height: hourHeight * 0.5)
                                    TimeBlock(session: ProtoSession.sessions[0], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[1], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[2], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[3], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight)
                                }
                                // Afternoon
                                Group {
                                    TimeBlock(session: ProtoSession.sessions[4], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[5], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[6], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                }
                                Group {
                                    TimeBlock(session: ProtoSession.sessions[7], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[8], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[9], showContents: !self.isCollapsedList[0], color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                }
                            }
                            .onTapGesture {
                                self.presentingIndex = 0
                            }
                            Timeline(isCollapsed: self.$isCollapsedList[1].animation()) {
                                Spacer()
                                    .frame(height: hourHeight * 4 + spacing * 3)
                                TimeBlock(session: ProtoSession.teatime[0], showContents: !self.isCollapsedList[1], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[2], showContents: !self.isCollapsedList[1], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[4], showContents: !self.isCollapsedList[1], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[6], showContents: !self.isCollapsedList[1], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                            }
                            .onTapGesture {
                                self.presentingIndex = 1
                            }
                            Timeline(isCollapsed: self.$isCollapsedList[2].animation()) {
                                Spacer()
                                    .frame(height: hourHeight * 4 + spacing * 3)
                                TimeBlock(session: ProtoSession.teatime[1], showContents: !self.isCollapsedList[2], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[3], showContents: !self.isCollapsedList[2], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[5], showContents: !self.isCollapsedList[2], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[7], showContents: !self.isCollapsedList[2], color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                            }
                            .onTapGesture {
                                self.presentingIndex = 2
                            }
                            Timeline(isCollapsed: self.$isCollapsedList[3].animation()) {
                                Spacer()
                                    .frame(height: hourHeight * 4 + spacing * 3)
                                TimeBlock(session: ProtoSession.workshop[0], showContents: !self.isCollapsedList[3], color: Color(.timelineWorkshop), height: hourHeight * 11 / 6 + spacing)
                                Spacer()
                                    .frame(height: (hourHeight + spacing) * 1 / 6)
                                TimeBlock(session: ProtoSession.workshop[1], showContents: !self.isCollapsedList[3], color: Color(.timelineWorkshop), height: hourHeight * 11 / 6 + spacing)
                                Spacer()
                            }
                            .onTapGesture {
                                self.presentingIndex = 3
                            }
                        }
                        TimeBlock(session: ProtoSession(title: "🎟 등록 및 입장",
                                                        speaker: "",
                                                        level: "",
                                                        time: "09:00 - 09:30"),
                                  showContents: true,
                                  color: Color(.timelineEvent),
                                  height: hourHeight * 0.5)
                        TimeBlock(session: ProtoSession(title: "🍽 점심",
                                                        speaker: "",
                                                        level: "",
                                                        time: "12:00 - 13:00"),
                                  showContents: true,
                                  color: Color(.timelineEvent),
                                  height: hourHeight)
                            .offset(y: (hourHeight + spacing) * 3)
                    }
                }
                .padding()
                .animation(animation)
                .gesture(DragGesture()
                .onEnded {
                    self.dragEndAction($0)
                })
                
                // MARK: - Legion
                TimelineLegionSection()
                Spacer()
            }
            .navigationBarTitle("일정")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear {
            #if !DEBUG
            SKStoreReviewController.requestReview()
            #endif
        }
    }
    
    // MARK: - Body Builder
    var animation: Animation {
        Animation
            .spring()
            .speed(2)
    }
    
    // MARK: - Helper
    func dragEndAction(_ value: DragGesture.Value) {
        if value.translation.width < -50 {
            presentingIndex = min(presentingIndex + 1, isCollapsedList.count - 1)
        } else if value.translation.width > 50 {
            presentingIndex = max(presentingIndex - 1, 0)
        }
    }
}

// MARK: - Preview
struct TimelineView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TimelineView()
            TimelineView()
                .environment(\.colorScheme, .dark)
            TimelineView()
                .environment(\.sizeCategory, .extraExtraExtraLarge)
        }
    }
}
