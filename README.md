#Weekly calendar for PowerShell.
今週のカレンダーを表示するPowerShellスクリプトです。  
[shellscript版のxcal](https://github.com/Takeru-chan/xcal)をPowerShellで書き直しています。  
とりあえず今月の表示まで。  

##Usage | 使い方
引数なしで起動すると今月のカレンダーを表示します。  
今日の日付をハイライト表示します。  
オプションに"-w"を指定すると、今週のカレンダーのみを表示します。  
$profileの最後に実行させると便利かな。。。  

```
(*'-')C:\Users\IEUser>>get-date

Tuesday, September 08, 2015 7:48:24 AM


(*'-')C:\Users\IEUser>>./wcal.ps1 -w
September 2015 (251/365)
 Su Mo Tu We Th Fr Sa
  6  7  8  9 10 11 12

(*'-')C:\Users\IEUser>>./wcal.ps1
   September 2015
Su Mo Tu We Th Fr Sa
       1  2  3  4  5
 6  7  8  9 10 11 12
13 14 15 16 17 18 19
20 21 22 23 24 25 26
27 28 29 30
```

##License
This script has released under the MIT license.  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)
