#Display calendar for PowerShell.
カレンダーを表示するPowerShellスクリプトです。  
[shellscript版のxcal](https://github.com/Takeru-chan/xcal)をPowerShellで書き直しています。  
まだ複数月の表示ができません。  

##Usage | 使い方
引数なしで起動すると今月のカレンダーを表示し、今日の日付をハイライトします。  
-mオプションに続けて表示月を指定できます。月指定に続けて年指定もできます。  
オプションに"-w"を指定すると、今週のカレンダーのみを表示します。  
$profileの最後に実行させると便利かな。。。  

環境変数XCALWEEKに指定した曜日をマゼンタ表示します。  
日曜：0, 月曜：1, ... 土曜：6  
土日休みの例）XCALWEEK=0,6

![プログラム実行例](./wcal.png)

##License
This script has released under the MIT license.  
[http://opensource.org/licenses/MIT](http://opensource.org/licenses/MIT)
