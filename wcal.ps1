param($correct=0)
$endofmonth=@(0,31,28,31,30,31,30,31,31,30,31,30,31)
$monthodr=@("","January","Febrary","March","April","May","June","July","August","September","October","November","December")
$weekodr=@("Su","Mo","Tu","We","Th","Fr","Sa")
$today=get-date
$year=$today.year
$month=$today.month
$day=$today.day
$week=[string]$today.dayofweek
$todaypoint=$today.dayofyear
if ($year % 4 -eq 0 -and $year % 100 -ne 0 -or $year % 400 -eq 0) {
    $endofmonth[2]++
}
for ($i = 1; $i -le 12; $i++) {
	$endofmonth[0]=$endofmonth[0] + $endofmonth[$i]
}
$endofcurrmonth=$endofmonth[$month]
$endofprevmonth=$endofmonth[$month - 1]
for ($i = 0; $i -lt 7; $i++) {
    if (($week).substring(0,2) -eq $weekodr[$i]) {
        $currweek=$i
    }
}
"{0} {1}, {2} ({3}/{4})" -f $monthodr[$month],$day,$year,$todaypoint,$endofmonth[0]
"{0,3}{1,3}{2,3}{3,3}{4,3}{5,3}{6,3}" -f $weekodr
$dateseq=@(0,0,0,0,0,0,0,0)
$marker=@("  ","  ","  ","  ","  ","  ","  ")
$dateseq[0]=$day - $currweek + 7 * $correct
for ($n = 0; $n -lt 7; $n++) {
    $dateseq[$n + 1]=$dateseq[$n] + 1
    if ($dateseq[$n] -le 0) {
        $dateseq[$n]=$dateseq[$n]+$endofprevmonth
    } elseif ($dateseq[$n] -gt $endofcurrmonth) {
        $dateseq[$n]=$dateseq[$n]-$endofcurrmonth
    }
    if ($n -eq $currweek) {
        $marker[$n] = "^^"
    } else {
        $marker[$n] = "  "
	}
}
"{0,3}{1,3}{2,3}{3,3}{4,3}{5,3}{6,3}" -f $dateseq
"{0,3}{1,3}{2,3}{3,3}{4,3}{5,3}{6,3}" -f $marker
