# Rakudo Star

[![Build Status](https://travis-ci.org/perl6/docker.svg?branch=master)](https://travis-ci.org/perl6/docker)

This Docker image includes Rakudo Star, an early adopter distribution of the Rakudo Perl 6 compiler, in addition
to some modules users may find helpful.

Project homepage: http://rakudo.org

GitHub repository: https://github.com/rakudo/star

The Dockerfile responsible: http://github.com/perl6/docker/tree/master/Dockerfile

Perl 6 Language Specification: http://design.perl6.org/

Perl 6 Language Documentation: http://doc.perl6.org/

# Usage

Simply running a container with the image will launch a Perl 6 REPL:

    $ docker run -it rakudo-star
    > say 'Hello, Perl!'
    Hello, Perl!

You can also provide perl6 command line switches to `docker run`:

    $ docker run -it rakudo-star perl6 -e 'say "Hello!"'

In addition, you can mount a directory from the host within a container:

    $ docker run -it -v $HOME/my_p6_projects/:/mount_location/ rakudo-star /bin/bash

Then, you can run your scripts from inside the container:

    # perl6 /mount_location/my_p6_script.p6

# Contributing/Getting Help

Many Perl 6 developers are present on #perl6 on Freenode.

Issues for Rakudo are tracked in RT: https://rt.perl.org/
