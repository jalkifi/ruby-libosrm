require "mkmf-rice"

require "fileutils"
require "yaml"

def do_help
  print <<HELP
usage: ruby #{$0} [options]
HELP
  exit! 0
end

case
when arg_config("--help")
    do_help
end

message "Building ruby-libosrm using system libraries.\n"

$INCFLAGS << " -I/usr/local/include/osrm"
$LDFLAGS  << " -L/usr/local/lib"

abort "Unable to find necessary libraries" unless
    have_library("boost_system") &&
    have_library("boost_filesystem") &&
    have_library("boost_iostreams") &&
    have_library("boost_thread") &&
    have_library("osrm")

$CXXFLAGS << " -std=c++17"

create_makefile "libosrm/ruby_libosrm"
