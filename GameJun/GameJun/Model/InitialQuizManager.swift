//
//  InitialQuizManager.swift
//  GameJun
//
//  Created by JEON JUNHA on 2021/05/06.
//

import Foundation

struct InitialQuizManager {
    static var shared = InitialQuizManager()
    let movieTitle = ["주유소 습격사건", "친구", "마스크", "나는 내일 어제의 너와 만난다", "달콤한 인생", "악마를 보았다", "옹박", "라이언 일병 구하기", "미션 임파서블"]
    var movieTitle2 = [""]
    private init(){}
}
