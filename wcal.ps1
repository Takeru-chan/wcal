Param([Switch] $w)
#
#-------------------------------------------
# wcal.ps1 ver.0.3  2015.9.12  (c)Takeru.
#
#
#      Copyright (c) 2015 Takeru.
#      Release under the MIT license
#      http://opensource.org/licenses/MIT
#
#-------------------------------------------
#
$current = Get-Date
$month_odr = @(@("", 0), @("January", 31) ,@("Febrary", 28), @("March", 31), @("April", 30),
            @("May", 31), @("June", 30), @("July", 31), @("August", 31),
            @("September", 30), @("October", 31), @("November", 30),@("December", 31))
$week_odr = @("Su", "Mo", "Tu", "We", "Th", "Fr", "Sa")
if ($current.Year % 4 -eq 0 -And $current.Year % 100 -ne 0 -Or $current.Year % 400 -eq 0) {
    $month_odr[2][1]++
}
$curr_dateyear = 0
for ($i = 1; $i -le 12; $i++) {
    $curr_dateyear = $curr_dateyear + $month_odr[$i][1]
}
for ($i = 0; $i -lt 7; $i++) {
    if (([String]$current.DayOfWeek).SubString(0,2) -eq $week_odr[$i]) {
        $curr_week = $i
    }
}
$disp_date = New-Object "Object[]" 126
$fg_wd = $(Get-Host).UI.rawUI.ForegroundColor
$bg_nm = $(Get-Host).UI.rawUI.BackgroundColor
$fg_hd = "Magenta"
$bg_td = "Gray"
$date_count = $current.Day - $curr_week
if ($date_count -ge 0) {
    $date_count = $date_count % 7
}
if (($date_count -gt 1) -And (-Not $w)) {
    $date_count = $date_count - 7
}
for ($n = 0; $n -lt 42; $n++) {
    if (($date_count -le 0) -Or ($date_count -gt $month_odr[$current.Month][1])) {
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
    if ($date_count -eq $current.day) {
        $disp_date[3 * $n + 2] = $bg_td
    } else {
        $disp_date[3 * $n + 2] = $bg_nm
    }
    $date_count++
}
$title = $month_odr[$current.Month][0] + " " + $current.Year
if ($w) {
    $title = $title + " (" + $current.DayOfYear + "/" + $curr_dateyear + ")"
    $loop = 1
    } else {
    for ($n = 0; $n -lt (20 - $title.length)/2; $n++) {
        Write-Host " " -NoNewLine
    }
    $loop = 6
}
Write-Host $title
for ($n = 0; $n -lt 7; $n++) {
    if (($n -eq 0) -Or ($n -eq 6)) {
        Write-Host $week_odr[$n] -NoNewLine -ForegroundColor Magenta
    } else {
        Write-Host $week_odr[$n] -NoNewLine
    }
    Write-Host " " -NoNewLine
}
Write-Host
for ($i = 0; $i -lt $loop; $i++) {
    for ($j = 0; $j -lt 7; $j++) {
        Write-Host $disp_date[($i * 7 + $j) * 3] -NoNewLine -ForegroundColor $disp_date[($i * 7 + $j) * 3 + 1] -BackgroundColor $disp_date[($i * 7 + $j) * 3 + 2]
        Write-Host " " -NoNewLine
    }
    Write-Host
}
if ($w) {
    Write-Host
}
