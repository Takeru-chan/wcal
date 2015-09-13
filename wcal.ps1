Param([Switch] $w, [Int] $m, [Int] $y)
#
#--------------------------------------------------------------------------
# wcal.ps1 ver.0.4  2015.9.13  (c)Takeru.
#
# Usage:
#       wxal.ps1 [-m month [year]]
#       wxal.ps1 -w
#
# Description:
#       The wcal utility displays a simple calendar.
#       If arguments are not specified, the current month is displayed.
#
#       -m      Display the specified month.
#       -w      Display only this week.
#
#       Copyright (c) 2015 Takeru.
#       Release under the MIT license
#       http://opensource.org/licenses/MIT
#
#--------------------------------------------------------------------------
#
$current = Get-Date
# 表示年月を指定
if (($m -ge 1) -And ($m -le 12) -And (-Not $w)) {
    if (($y -ge 1753) -And ($y -le 9999)) {
        $disp_cal = New-Object DateTime $y, $m, 1
    } else {
        $disp_cal = New-Object DateTime $current.year, $m, 1
    }
} else {
    $disp_cal = New-Object DateTime $current.year, $current.month, 1
}
# 閏年チェック
$month_odr = @(@("", 0), @("January", 31) ,@("Febrary", 28), @("March", 31), @("April", 30),
            @("May", 31), @("June", 30), @("July", 31), @("August", 31),
            @("September", 30), @("October", 31), @("November", 30),@("December", 31))
$curr_dateyear = 365
if ($w) {
    $chk_year = $current.Year
} else {
    $chk_year = $disp_cal.Year
}
if ($chk_year % 4 -eq 0 -And $chk_year % 100 -ne 0 -Or $chk_year % 400 -eq 0) {
    $month_odr[2][1]++                  # 閏年なら2月29日を追加
    $curr_dateyear++
}                                       # 当該年の日数を補正
# 月タイトル表示
$title = $month_odr[$disp_cal.Month][0] + " " + $disp_cal.Year
if ($w) {
    $title += " (" + $current.DayOfYear + "/" + $curr_dateyear + ")"
    $loop = 1                           # ここは$current.DayOfYearでないとダメ
} else {
    $pre_title = " " * ((20 - $title.length) / 2)
    Write-Host $pre_title -NoNewLine
    $loop = 6
}
Write-Host $title
# 曜日タイトル表示
$week_odr = @("Su", "Mo", "Tu", "We", "Th", "Fr", "Sa")
for ($n = 0; $n -lt 7; $n++) {
    if (($n -eq 0) -Or ($n -eq 6)) {
        Write-Host $week_odr[$n] -NoNewLine -ForegroundColor Magenta
    } else {
        Write-Host $week_odr[$n] -NoNewLine
    }
    Write-Host " " -NoNewLine
}
Write-Host
# 本体表示開始
$fg_wd = $(Get-Host).UI.rawUI.ForegroundColor
$bg_nm = $(Get-Host).UI.rawUI.BackgroundColor
$fg_hd = "Magenta"
$bg_td = "Gray"
if ($w) {                               # 今週の日曜の日付を取得
    $chk_week = $current.DayOfWeek
    $target_day = $current.Day
} else {                                # 第１週の日曜の日付を取得
    $chk_week = $disp_cal.DayOfWeek
    $target_day = $disp_cal.Day
}
for ($i = 0; $i -lt 7; $i++) {
    if (([String]$chk_week).SubString(0,2) -eq $week_odr[$i]) {
        $curr_week = $i                 # 曜日文字列を0..6に変換
    }
}
$date_count = $target_day - $curr_week
$disp_date = New-Object Object[] 126
for ($n = 0; $n -lt 42; $n++) {
    if (($date_count -le 0) -Or ($date_count -gt $month_odr[$disp_cal.Month][1])) {
        $disp_date[3 * $n] = "  "
    } elseif ($date_count -lt 10) {
        $disp_date[3 * $n] = " " + $date_count
    } else {
        $disp_date[3 * $n] = [String]$date_count
    }
    if (($n % 7 -eq 0) -Or ($n % 7 -eq 6)) {
        $disp_date[3 * $n + 1] = $fg_hd
    } else {
        $disp_date[3 * $n + 1] = $fg_wd
    }
    if (($date_count -eq $current.day) -And ($disp_cal.month -eq $current.month) -And ($disp_cal.year -eq $current.year)) {
        $disp_date[3 * $n + 2] = $bg_td
    } else {
        $disp_date[3 * $n + 2] = $bg_nm
    }
    $date_count++
}
for ($i = 0; $i -lt $loop; $i++) {
    for ($j = 0; $j -lt 7; $j++) {
        Write-Host $disp_date[($i * 7 + $j) * 3] -NoNewLine -ForegroundColor $disp_date[($i * 7 + $j) * 3 + 1] -BackgroundColor $disp_date[($i * 7 + $j) * 3 + 2]
        Write-Host " " -NoNewLine
    }
    Write-Host                          # 週の改行
}
Write-Host                              # 月の改行
