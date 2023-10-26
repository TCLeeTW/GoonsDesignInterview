#  Interview Task Instruction

## 環境

IDE：Xcode 14.0 ~

Swift：Swift 5.7 ~

Minimum Target：iOS 13 ~

## **功能描述**

1. 搜尋功能
    1. 使用GitHub API **`search/repositories`** 進行搜尋，並顯示搜尋結果
    2. 輸入關鍵字後，Search Bar 出現清除按鈕
    3. 清除按鈕動作： Search Bar 中的文字及搜尋結果
2. 搜尋結果列表
    1. 顯示資料：owner Icon、Repository name、description
    2. 點擊列表，跳轉至詳細頁
    3. 列表上拉至頂部執行Refresh 動作，並依照當前Search Bar中的文字進行重新搜尋
    4. 當前Search Bar 中，沒有文字，則顯示警告訊息
    5. 根據滑動變換Navigation Bar 樣式
3. 詳細頁
    1. 顯示資料： Repository name、owner icon、Program language、stars、Watcher、Fork、Issue
    2. 點擊 “< Back” 返回列表


GitHub API 說明網頁：https://docs.github.com/en/rest/search/search?apiVersion=2022-11-28#search-repositories
參考影片：https://drive.google.com/file/d/11ibCaL56nMXxjtplPVU5Iio1AeV7bpno/view?usp=sharing
