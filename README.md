# Rakudo Star

[![Build Status](https://travis-ci.org/perl6/docker.svg?branch=master)](https://travis-ci.org/perl6/docker)

This Docker image includes Rakudo Star, an early adopter distribution of the Rakudo Perl 6 compiler, in addition
to some modules users may find helpful.

Project homepage: http://rakudo.org

GitHub repository: https://github.com/rakudo/star

The Dockerfile responsible: http://github.com/perl6/docker/tree/master/Dockerfile

Perl 6 Language Specification: http://design.perl6.org/

Perl 6 Language Documentation: http://doc.perl6.org/

# Build

You can build an image from this Dockerfile as indicated below:

    $ docker build -t rakudo-star /path_to_dockerfile/

In addition, you can specify the version of Rakudo Star that you want at build time:

    $ docker build --build-arg rakudo_version=${DESIRED_VERSION} -t rakudo-star /path_to_dockerfile/

If no version is specified, it will default to the version listed in the Dockerfile. It is recommended that
you use the default version.

# Usage

Simply running a container with the image will launch a Perl 6 REPL:

    $ docker run -it rakudo-star
    > say 'Hello, Perl!'
    Hello, Perl!

You can also provide perl6 command line switches to `docker run`:

    $ docker run -it rakudo-star perl6 -e 'say "Hello!"'

# Contributing/Getting Help

Many Perl 6 developers are present on #perl6 on Freenode.

Issues for Rakudo are tracked in RT: https://rt.perl.org/
