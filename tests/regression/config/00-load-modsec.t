{
	type => "config",
	comment => "module loaded",
	match_log => {
		error => {
			apache_v3 => [ qr/CeleoWAF-Apache/, 10 ],
			apache => [ qr/CeleoWAF for Apache.* configured\./, 10 ],
			nginx => [ qr/CeleoWAF for nginx.* configured\./, 10 ],
		},
	},
},
{
	type => "config",
	comment => "minimal config",
	conf => sub {
		# Open the minimal conf file, substituting the
		# relative log paths with full paths.
		open(C, "<$ENV{DIST_ROOT}/celeowaf.conf-minimal") or die "$!\n";
		(my $conf = join('', <C>)) =~ s#Log logs/#Log $ENV{TEST_SERVER_ROOT}/logs/#g;
		close C;

		return $conf;
	},
	match_log => {
		error => {
			apache_v3 => [ qr/CeleoWAF-Apache/, 10 ],
			apache => [ qr/CeleoWAF for Apache.* configured\./, 10 ],
			nginx => [ qr/CeleoWAF for nginx.* configured\./, 10 ],
		},
	},
},
