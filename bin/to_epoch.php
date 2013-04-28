#!/usr/local/bin/php

<?php

if ($argc < 2) {
    print "usage: $argv[0] hour minute second month day year\n";
    exit(1);
}


print mktime($argv[1], $argv[2], $argv[3], $argv[4], $argv[5], $argv[6]) . "\n";

?>
