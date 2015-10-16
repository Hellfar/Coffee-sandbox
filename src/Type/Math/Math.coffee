gcd = ( f, s ) ->
	if f % s then gcd(s, f % s) else s
