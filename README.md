# Convert a h-resume to a Linux man page

This repository contains a Perl script to convert a h-resume to a Linux man page.

## Getting Started

First, install all of the required dependencies for this project:

    cpan install Web::Microformats2
    cpan install LWP::UserAgent

Next, open the `h-entry-to-man.pl` script and replace `jamesg.blog/resume/` with the location of your h-resume document. Only valid h-resume objects will be added to the manual page.

Finally, run the script:

    perl h-entry-to-man.pl

The script will create a file called `manual.man`.

To open the man file, use this command:

    man ./manual.man

_(Note the `./` is needed to open the file.)_

## License

This project is licensed under an [MIT 0 license](LICENSE).

## Contributors

- capjamesg