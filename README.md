#Weekly calendar for PowerShell.
OSXのコマンドラインで動く日付計算コマンドです。  
今日を起点に指定した日数前または日数後の日付を返します。
ただし計算可能な期間は西暦1100年から9999年の間のみ。  

##Usage | 使い方
今週のカレンダーを表示します。  
１行目には今日の日付と年初からの日数を表示します。  
今週のカレンダーの部分には、今日の曜日の下に"^^"マークを表示します。  

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
