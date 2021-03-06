Param([Switch] $h, [Switch] $v, [Switch] $w, [Int] $m, [Int] $y)
#--------------------------------------------------------------------------
$credit = @"

  wcal.ps1 ver.0.53  2016.2.3  (c)Takeru.
 
  Usage:
        wcal.ps1 [-m month [year]]
        wcal.ps1 -w
        wcal.ps1 -v
 
  Description:
        The wcal utility displays a simple calendar.
        If arguments are not specified, the current month is displayed.
 
        -m      Display the specified month.
        -w      Display only this week.
        -v      Display this credit.
 
        Copyright (c) 2015 Takeru.
        Release under the MIT license
        http://opensource.org/licenses/MIT
 
"@
#--------------------------------------------------------------------------
if (($v) -Or ($h)) {
	$credit
	return
}
# 環境変数読み込み
$env_lst = @("WEEK", "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC")
$hol_wk = @(9, 9, 9, 9, 9, 9, 9)
for ($n = 0; $n -le 12; $n++) {
	$env_lst[$n] = [System.Environment]::GetEnvironmentVariable("XCAL" + $env_lst[$n])
}
for ($n =0; $n -lt $env_lst[0].Length; $n++) {
	switch ($env_lst[0][$n]) {
		0 {$hol_wk[0] = 0}
		1 {$hol_wk[1] = 1}
		2 {$hol_wk[2] = 2}
		3 {$hol_wk[3] = 3}
		4 {$hol_wk[4] = 4}
		5 {$hol_wk[5] = 5}
		6 {$hol_wk[6] = 6}
	}
}
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
    if ($hol_wk[$n] -ne 9) {			# 指定週を休日色に
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
    if ($hol_wk[$n % 7] -ne 9) {		# 指定週を休日色に
        $disp_date[3 * $n + 1] = $fg_hd
    } else {
        $disp_date[3 * $n + 1] = $fg_wd
    }
    if (($date_count -eq $current.day) -And ($disp_cal.month -eq $current.month) -And ($disp_cal.year -eq $current.year)) {
        $disp_date[3 * $n + 2] = $disp_date[3 * $n + 1]
        $disp_date[3 * $n + 1] = $bg_nm
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
if ($w) {
	$first_sunday = ($current.DayOfYear - $curr_week) % 7
	$week_us = 1 + ($current.DayOfYear - $curr_week - $first_sunday) / 7
	if ($first_sunday -ne 1) {
		$week_us++						# １月最初の日曜日が元日でなければ、先週が第１週
	}
	if ($week_us -ge 53) {$week_us = 1}
	Write-Host "Week" $week_us "(US) / " -NoNewLine
	$first_monday = ($current.DayOfYear - $curr_week + 1) % 7
	$week_eu = 1 + ($current.DayOfYear - $curr_week - $first_monday + 1) / 7
	if ($first_monday -gt 4) {
		$week_eu++ 						# １月最初の月曜日が４日よりも後であれば、先週が第１週
	}
	if ($curr_week -eq 0) {				# EUの週始まりは月曜
		$week_eu--
	}
	if ($week_eu -ge 53) {$week_eu = 1}
	Write-Host "Week" $week_eu "(EU/ISO)"
}
Write-Host                              # 月の改行
