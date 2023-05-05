// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

import jquery from "jquery";
window.$ = jquery;

// jquery書きはじめ
$(function () {
  // 処理（ページが読み込まれた時、フォームに残り何文字入力できるかを数えて表示する）

  //フォームに入力されている文字数を数える
  //\nは"改行"に変換して2文字にする。オプションフラグgで文字列の最後まで\nを探し変換する
  let count = $(".js-text").text().replace(/\n/g, "改行").length;
  //残りの入力できる文字数を計算
  let now_count = 200 - count;
  //文字数がオーバーしていたら文字色を赤にする
  if (count > 200) {
    $(".js-text-count").css("color", "red");
  }
  //残りの入力できる文字数を表示
  $(".js-text-count").text("残り" + now_count + "文字");

  $(".js-text").on("keyup", function () {
    // 処理（キーボードを押した時、フォームに残り何文字入力できるかを数えて表示する）
    //フォームのvalueの文字数を数える
    let count = $(this).val().replace(/\n/g, "改行").length;
    let now_count = 200 - count;

    if (count > 200) {
      $(".js-text-count").css("color", "red");
    } else {
      $(".js-text-count").css("color", "black");
    }
    $(".js-text-count").text("残り" + now_count + "文字");
  });
});

document.addEventListener("turbo:before-fetch-response", function (event) {
  const json = JSON.parse(
    event.detail.fetchResponse.header("X-Flash-Messages")
  );

  // メッセージを表示する
  for (let key in json) {
    // ↓ これがflashメッセージを出すfunction
    flash_submit(key, decodeURI(json[key]));
  }
});
