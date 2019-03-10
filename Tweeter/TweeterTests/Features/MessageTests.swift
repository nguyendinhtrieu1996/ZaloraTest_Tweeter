//
//  MessageTests.swift
//  TweeterTests
//
//  Created by MACOS on 3/10/19.
//  Copyright © 2019 MACOS. All rights reserved.
//

import XCTest
@testable import Tweeter

class MessageTests: XCTestCase {
    let text10Character = "0123456789"
    let text50Character = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    let textSplitTwoParts = "I can't believe Tweeter now supports chunking my messages, so I don't have to do it myself."
    let textSplit26Parts = """
Với nhiều ưu điểm như vậy, vòng tránh thai cũng dần trở thành một công cụ hữu ích được nhiều chị em lựa chọn. Tuy nhiên, vì là một vật thể được đưa vào cơ thể với mục đích y khoa nên vòng tránh thai vẫn có thể mang đến cho bạn hàng loạt tác dụng phụ không mong muốn. Dưới đây là một vài tác dụng phụ khi sử dụng vòng tránh thai mà bạn nên biết trước khi quyết định sử dụng phương pháp này. Làm chu kỳ kinh nguyệt kéo dài và ra nhiều hơn
    Theo Bác sĩ phụ khoa Elizabeth Reynoso (MomDoc Women For Women ở Arizona, Mỹ), một trong những tác dụng phụ thường gặp nhất của vòng tránh thai căn cứ theo số lượng nghiên cứu từ trang Women's Health Magazine trong thời gian gần đây là phương pháp này làm kéo dài thời gian và khiến lượng máu kinh tiết ra nhiều hơn bình thường.
    
    Một nghiên cứu khác được công bố từ năm 2010 trên tạp chí Contraception, hơn 2/3 đối tượng nữ giới phàn nàn về việc họ chảy máu nhiều hơn trong năm đầu tiên sử dụng vòng tránh thai. Để kiểm soát được tình trạng này, bạn nên tìm tới bác sĩ chuyên khoa để chuyển sang một phương pháp tránh thai khác an toàn hơn.
"""

    let textSplit108Parts = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. A pellentesque sit amet porttitor eget dolor. A diam maecenas sed enim ut sem viverra. Nibh nisl condimentum id venenatis a condimentum. Tristique senectus et netus et malesuada. Porta nibh venenatis cras sed felis eget velit aliquet sagittis. Sagittis eu volutpat odio facilisis mauris sit amet massa. Id porta nibh venenatis cras. Orci ac auctor augue mauris augue. Semper viverra nam libero justo laoreet sit amet cursus sit. Pulvinar elementum integer enim neque. Gravida cum sociis natoque penatibus et magnis dis. Pellentesque diam volutpat commodo sed egestas egestas fringilla phasellus faucibus. Turpis egestas integer eget aliquet nibh praesent tristique magna.
    Morbi tristique senectus et netus. Tristique nulla aliquet enim tortor. Ipsum faucibus vitae aliquet nec. Interdum velit laoreet id donec. Lacus luctus accumsan tortor posuere ac. Convallis tellus id interdum velit laoreet. Faucibus turpis in eu mi bibendum. Ultrices mi tempus imperdiet nulla malesuada pellentesque elit eget gravida. Feugiat in ante metus dictum at tempor commodo ullamcorper a. Tristique et egestas quis ipsum suspendisse ultrices gravida dictum. Cursus in hac habitasse platea dictumst. Augue ut lectus arcu bibendum at varius vel. Nec nam aliquam sem et tortor. Tempor nec feugiat nisl pretium fusce id velit ut tortor. Pharetra convallis posuere morbi leo urna molestie at elementum. Dui accumsan sit amet nulla facilisi morbi tempus iaculis urna. Interdum varius sit amet mattis vulputate enim nulla aliquet porttitor. Condimentum vitae sapien pellentesque habitant morbi.
    Vitae proin sagittis nisl rhoncus mattis rhoncus urna. Eu feugiat pretium nibh ipsum consequat. Eget felis eget nunc lobortis mattis aliquam faucibus purus. Sed turpis tincidunt id aliquet risus. Rhoncus urna neque viverra justo. Vulputate eu scelerisque felis imperdiet proin fermentum leo. Congue quisque egestas diam in arcu cursus euismod quis viverra. Sapien et ligula ullamcorper malesuada proin libero nunc consequat interdum. Mauris commodo quis imperdiet massa. Neque gravida in fermentum et sollicitudin ac orci phasellus egestas. Nunc consequat interdum varius sit amet mattis vulputate enim nulla. Dui sapien eget mi proin. Cras pulvinar mattis nunc sed blandit libero volutpat. Ultrices sagittis orci a scelerisque purus semper eget duis.
    Viverra orci sagittis eu volutpat. Adipiscing elit ut aliquam purus sit amet. Interdum velit laoreet id donec. Morbi tristique senectus et netus et. Consequat ac felis donec et odio pellentesque. Magna fringilla urna porttitor rhoncus dolor purus non enim. Quam pellentesque nec nam aliquam sem et tortor consequat id. Risus ultricies tristique nulla aliquet. Congue nisi vitae suscipit tellus. Maecenas sed enim ut sem viverra aliquet eget sit. Arcu non sodales neque sodales ut etiam sit. In nulla posuere sollicitudin aliquam. Donec adipiscing tristique risus nec feugiat in fermentum. Sed vulputate mi sit amet mauris commodo. Gravida neque convallis a cras semper auctor neque vitae. Ultrices tincidunt arcu non sodales neque sodales.
    Varius sit amet mattis vulputate enim nulla aliquet porttitor lacus. Proin libero nunc consequat interdum. Praesent tristique magna sit amet purus gravida quis blandit. Nullam eget felis eget nunc lobortis mattis aliquam faucibus. A cras semper auctor neque vitae tempus quam. Leo in vitae turpis massa sed elementum tempus egestas. Egestas fringilla phasellus faucibus scelerisque eleifend donec pretium vulputate sapien. Enim sit amet venenatis urna cursus. Molestie a iaculis at erat pellentesque adipiscing commodo elit. Nunc non blandit massa enim.
    Elit scelerisque mauris pellentesque pulvinar. Nunc mi ipsum faucibus vitae aliquet nec. Tellus in hac habitasse platea. Enim nec dui nunc mattis enim ut tellus elementum. Massa id neque aliquam vestibulum morbi blandit cursus risus. Amet tellus cras adipiscing enim eu. Non sodales neque sodales ut. Ultrices sagittis orci a scelerisque purus semper eget duis at. Amet aliquam id diam maecenas ultricies. Id interdum velit laoreet id donec ultrices tincidunt arcu. Arcu ac tortor dignissim convallis. Hendrerit dolor magna eget est lorem ipsum dolor sit. Id leo in vitae turpis.
"""
    
    let textDoNotContainWhiteSpace = "2323 0349209320932093209320932093209320932039203920392"
    
    override func setUp() {
    }

    override func tearDown() {
    }

    func testSplitMessage_ReturnMessageWhenLessThanMaxLength() {
        let messages = Message.splitMessage(text10Character)
        XCTAssertEqual(messages?.count, 1)
        XCTAssertEqual(messages?.first, Message(text: text10Character))
    }
    
    func testSplitMessage_ReturnMessageWhenEqualMaxLength() {
        let messages = Message.splitMessage(text50Character)
        XCTAssertEqual(text50Character.count, Message.maxLenght)
        XCTAssertEqual(messages?.count, 1)
        XCTAssertEqual(messages?.first, Message(text: text50Character))
    }
    
    func testSplitMessage_Return2Parts() {
        let messages = Message.splitMessage(textSplitTwoParts)
        XCTAssertEqual(messages?.count, 2)
    }
    
    func testSplitMessage_Return26Parts() {
        let messages = Message.splitMessage(textSplit26Parts)
        XCTAssertEqual(messages?.count, 26)
    }
    
    func testSplitMessage_Return108Parts() {
        let messages = Message.splitMessage(textSplit108Parts)
        XCTAssertEqual(messages?.count, 108)
    }
    
    func testSplitMessage_WhenTestDoNotContainWhiteSpace_ReturnNil() {
        let messages = Message.splitMessage(textDoNotContainWhiteSpace)
        XCTAssertNil(messages)
    }
    
}
