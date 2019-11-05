//
//  TimelineView.swift
//  LetSwift
//
//  Created by BumMo Koo on 2019/11/04.
//  Copyright © 2019 Cleanios. All rights reserved.
//

import SwiftUI

struct TimelineView: View {
    @State var isCollapsed1 = false
    @State var isCollapsed2 = true
    @State var isCollapsed3 = true
    @State var isCollapsed4 = true
    
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
                            Timeline(isCollapsed: self.$isCollapsed1.animation()) {
                                Group {
                                    Spacer()
                                        .frame(height: hourHeight * 0.5)
                                    TimeBlock(session: ProtoSession.sessions[0], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[1], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[2], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[3], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight)
                                }
                                // Afternoon
                                Group {
                                    TimeBlock(session: ProtoSession.sessions[4], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[5], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[6], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                }
                                Group {
                                    TimeBlock(session: ProtoSession.sessions[7], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[8], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 4 / 6)
                                    Spacer()
                                        .frame(height: hourHeight * 1 / 6)
                                    TimeBlock(session: ProtoSession.sessions[9], showContents: !self.isCollapsed1, color: Color(.timelineSession), height: hourHeight * 2 / 6)
                                    Spacer()
                                }
                            }
                            .onTapGesture {
                                self.isCollapsed1 = false
                                self.isCollapsed2 = true
                                self.isCollapsed3 = true
                                self.isCollapsed4 = true
                            }
                            Timeline(isCollapsed: self.$isCollapsed2.animation()) {
                                Spacer()
                                    .frame(height: hourHeight * 4 + spacing * 3)
                                TimeBlock(session: ProtoSession.teatime[0], showContents: !self.isCollapsed2, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[2], showContents: !self.isCollapsed2, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[4], showContents: !self.isCollapsed2, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[6], showContents: !self.isCollapsed2, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                            }
                            .onTapGesture {
                                self.isCollapsed1 = true
                                self.isCollapsed2 = false
                                self.isCollapsed3 = true
                                self.isCollapsed4 = true
                            }
                            Timeline(isCollapsed: self.$isCollapsed3.animation()) {
                                Spacer()
                                    .frame(height: hourHeight * 4 + spacing * 3)
                                TimeBlock(session: ProtoSession.teatime[1], showContents: !self.isCollapsed3, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[3], showContents: !self.isCollapsed3, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[5], showContents: !self.isCollapsed3, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                                    .frame(height: hourHeight * 1 / 6)
                                TimeBlock(session: ProtoSession.teatime[7], showContents: !self.isCollapsed3, color: Color(.timelineTeatime), height: hourHeight * 5 / 6)
                                Spacer()
                            }
                            .onTapGesture {
                                self.isCollapsed1 = true
                                self.isCollapsed2 = true
                                self.isCollapsed3 = false
                                self.isCollapsed4 = true
                            }
                            Timeline(isCollapsed: self.$isCollapsed4.animation()) {
                                Spacer()
                                    .frame(height: hourHeight * 4 + spacing * 3)
                                TimeBlock(session: ProtoSession.workshop[0], showContents: !self.isCollapsed4, color: Color(.timelineWorkshop), height: hourHeight * 11 / 6 + spacing)
                                Spacer()
                                    .frame(height: (hourHeight + spacing) * 1 / 6)
                                TimeBlock(session: ProtoSession.workshop[1], showContents: !self.isCollapsed4, color: Color(.timelineWorkshop), height: hourHeight * 11 / 6 + spacing)
                                Spacer()
                            }
                            .onTapGesture {
                                self.isCollapsed1 = true
                                self.isCollapsed2 = true
                                self.isCollapsed3 = true
                                self.isCollapsed4 = false
                            }
                        }
                        TimeBlock(session: ProtoSession(title: "입장 및 등록",
                                                        speaker: "",
                                                        level: "",
                                                        time: ""),
                                  showContents: true,
                                  color: Color(.timelineEvent),
                                  height: hourHeight * 0.5)
                        TimeBlock(session: ProtoSession(title: "점심 시간",
                                                        speaker: "",
                                                        level: "",
                                                        time: ""),
                                  showContents: true,
                                  color: Color(.timelineEvent),
                                  height: hourHeight)
                            .offset(y: (hourHeight + spacing) * 3)
                    }
                }
                .padding()
                
                // MARK: - Legion
                TimelineLegionSection()
                Spacer()
            }
            .navigationBarTitle("일정")
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
