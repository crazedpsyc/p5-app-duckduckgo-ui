package App::DuckDuckGo::UI::Config;
# ABSTRACT: App::DuckDuckGo::UI configuration manager

use Config::Any;

my %defaults = (
    browser => "w3m %s",
    params => {},
    ssl => 0,
    debug => 0,
);

sub new {
    my %config = %defaults;

    my $config_home = $ENV{XDG_CONFIG_HOME} // "$ENV{HOME}/.config";
    my @files = Config::Any->load_stems({
            stems   => ["$config_home/duckduckgo-ui", "./duckduckgo-ui", "/etc/duckduckgo-ui"],
            use_ext => 1,
    });

    for my $file (@files) {
        my $cfg = $$file[0]->{(keys($$file[0]))[0]};
        $config{$_} = $$cfg{$_} for keys %$cfg;
    }

    return \%config;
}

1;
