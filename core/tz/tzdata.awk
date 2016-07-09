# usage: awk -f tzdata.awk repo=out/root.git out=out/core/tz/zoneinfo [file...]

function run(cmd) {
	status = system(cmd)
	if (status != 0)
		exit status
}

BEGIN {
	cmdfmt = "rc ./scripts/hash.rc %s %s share/zoneinfo/%s %s"
}

FNR == 1 {
	run(sprintf("zic -d %s %s", out, FILENAME))
}

$1 == "Link" {
	s = $3
	gsub(/[^\/]+/, "..", s)
	s = substr(s, 1, length(s) - 2) $2
	run(sprintf(cmdfmt, repo, 120000, $3, s))
}

$1 == "Zone" {
	run(sprintf(cmdfmt, repo, 100644, $2, out "/" $2))
}
