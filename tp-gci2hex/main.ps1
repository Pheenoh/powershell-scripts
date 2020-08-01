# input variable
$gcipath = "./s.gci"

$gci = Get-Content $gcipath -asbytestream

$qlog1 = $gci[0x4048..0x4AD3]
$qlog2 = $gci[0x4ADC..0x5567]
$qlog3 = $gci[0x5570..0x5FFB]

$qlog1 | Set-Content "./qlog1.bin" -AsByteStream
$qlog2 | Set-Content "./qlog2.bin" -AsByteStream
$qlog3 | Set-Content "./qlog3.bin" -AsByteStream