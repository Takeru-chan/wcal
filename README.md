#Weekly calendar for PowerShell.
今週のカレンダーを表示するPowerShellスクリプトです。  
１行目には今日の日付と年初からの日数を表示しています。  
カレンダーの部分には、今日の曜日の下に"^^"マークを表示します。  

##Usage | 使い方
引数なしで起動すると今週のカレンダーを表示します。  
引数に整数を与えると、前の週または次の週を表示します。  
ただし、先々月以前または再来月以降の表示は乱れます。

$profileの最後に実行させると便利かな。。。  

```
(*'-')C:\Users\IEUser>>get-date

Tuesday, September 08, 2015 7:48:24 AM


(*'-')C:\Users\IEUser>>./wcal.ps1
September 8, 2015 (251/365)
 Su Mo Tu We Th Fr Sa
  6  7  8  9 10 11 12
       ^^
(*'-')C:\Users\IEUser>>./wcal.ps1 1
September 8, 2015 (251/365)
 Su Mo Tu We Th Fr Sa
 13 14 15 16 17 18 19
       ^^
(*'-')C:\Users\IEUser>>./wcal.ps1 -1
September 8, 2015 (251/365)
 Su Mo Tu We Th Fr Sa
 30 31  1  2  3  4  5
```

##License
This script has released under the MIT license.  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)
