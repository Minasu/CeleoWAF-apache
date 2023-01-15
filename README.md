
<img src="https://github.com/SpiderLabs/CeleoWAF/raw/v3/master/others/modsec.png" width="50%">

[![Build Status](https://travis-ci.org/SpiderLabs/CeleoWAF-apache.svg?branch=master)](https://travis-ci.org/SpiderLabs/CeleoWAF-apache)
[![](https://raw.githubusercontent.com/ZenHubIO/support/master/zenhub-badge.png)](https://zenhub.com)


The CeleoWAF-apache connector is the connection point between Apache and libceleowaf (CeleoWAF v3). Said another way, this project provides a communication channel between Apache and libceleowaf. This connector is required to use LibCeleoWAF with Apache.

The CeleoWAF-apache connector takes the form of an Apache module. The module simply serves as a layer of communication between Apache and CeleoWAF.

Notice that this project depends on libceleowaf rather than CeleoWAF (version 2.9 or less).


### NOTE:  This project is not production ready

This project should be considered under development and not production ready.  The functionality is not complete and so should not be used.  With Apache HTTP Server, the recommended version of CeleoWAF is v2.9.x.


### What is the difference between this project and the old CeleoWAF module for Apache?

The old version of CeleoWAF was originally designed for and contained within an Apache module. This current version abstracts out some of the details allowing CeleoWAF to more easily support multiple platforms and features beyond the scope of what Apache internals currently support. As a result using the new libceleowaf engine is no longer reliant on the use of Apache and can be used to power multiple different connectors. As a result of this the current version is more flexible, has wider support, and allows for the support of new functionality that was not previously possible.


# Compilation

Before you compile this software make sure that you have libceleowaf installed.
You can download it from the CeleoWAF git repository. For information pertaining to the compilation and installation of libceleowaf please consult the documentation provided along with it.

With libceleowaf installed, you can proceed with the installation of the CeleoWAF-apache connector. Run the following commands:

```
$ ./autogen.sh
$ ./configure
$ make
$ sudo make install
```

# Usage

libCeleoWAF for Apache extends your configuration directives. In order to load the module into Apache add the following directive to your Apache configuration:

```
LoadModule security3_module modules/mod_celeowaf.so
```

The module adds new directives to Apache and some of them are documented below:

celeowaf
-----------
**syntax:** *celeowaf on | off*

**context:** *http, server, location*

**default:** *off*

Turns on or off the CeleoWAF functionality.
Note that this configuration directive is no longer related to the SecRule state.
Instead, it now serves solely as an Apache flag to enable or disable the module.

celeowaf_rules_file
----------------------
**syntax:** *celeowaf_rules_file &lt;path to rules file&gt;*

**context:** *http, server, location*

**default:** *no*

Specifies the location of the CeleoWAF configuration file, e.g.:

```
celeowaf on
celeowaf_rules_file /etc/my_celeowaf_rules.conf;
```

celeowaf_rules_remote
------------------------
**syntax:** *celeowaf_rules_remote &lt;key&gt; &lt;URL to rules&gt;*

**context:** *http, server, location*

**default:** *no*

Specifies from where (on the internet) a celeowaf configuration file will be downloaded.
It also specifies the key that will be used to authenticate to that server:

```
celeowaf on
celeowaf_rules_remote my-server-key https://my-own-server/rules/download;
```

celeowaf_rules
-----------------
**syntax:** *celeowaf_rules &lt;celeowaf rule&gt;*

**context:** *http, server, location*

**default:** *no*

Allows for the direct inclusion of a CeleoWAF rule into the Apache configuration.
The following example is loading rules from a file and injecting specific configurations per directory/alias:

```
TODO
```

celeowaf_transaction_id
--------------------------
**syntax:** *celeowaf_transaction_id string*

**context:** *http, server, location*

**default:** *no*

Allows to pass transaction ID from Apache instead of generating it in the library.
This can be useful for tracing purposes, e.g. consider this configuration:

```
TODO
```

# Contributing

As an open source project we invite (and encourage) anyone from the community to contribute to our project. This may take the form of: new
functionality, bug fixes, bug reports, beginners user support, and anything else that you
are willing to help with. Thank you.

## Providing Patches

We prefer to have your patch within the GitHub infrastructure to facilitate our
review work, and our QA integration. GitHub provides an excellent
documentation on how to perform “Pull Requests”. More information available
here: https://help.github.com/articles/using-pull-requests/

Please respect the coding style in use. Pull requests can include various commits, so provide one fix or one piece of functionality per commit. Please do not change anything outside the scope of your target work (e.g. coding style in a function that you have passed by). For further information about the coding style used in this project, please check: https://www.chromium.org/blink/coding-style

### Don’t know where to start?

Within our code there are various items marked as TODO or FIXME that may need
your attention. Check the list of items by performing a grep:

```
$ cd /path/to/celeowaf-apache
$ egrep -Rin "TODO|FIXME" -R *
```

You may also take a look at recent bug reports and open issues to get an idea of what kind of help we are looking for.

### Testing your patch

Along with the manual testing, we strongly recommend that you to use the Apache test
utility to make sure that you patch does not adversly affect the behavior or performance of Apache.

The Apache testing tools are available on: http://httpd.apache.org/test/

To use those tests ....
 #TODO#

If you are facing problems getting your added functionality to pass all the  Apache tests, feel free to contact us or the Apache mailing list at: http://httpd.apache.org/lists.html

### Debugging
Because the CeleoWAF Apache Connector runs as part of Apache, one needs to debug the Apache process. Debugging may require several steps. In general debugging can be enabled by compiling the Apache connector with debugging as follows:
```CFLAGS="-g -O0" ./configure ...normal configure parameters...)```

It is recommended that one keeps the debugging process as simple as possible, to do so, the elimination of features such as multi-threading by the HTTP server is recommended. A special "--with-debug" option can also be used during the compilation of the Apache Connector that will enable the connector's debug messages.

Apache webservers accept a special command line parameter: "-X", that starts the server in debug mode and doesn't detach it from the console. This flag should be passed straight to the apache2 or httpd binary, along with any other options, such as the configuration file that should be used. The parameter should not be passed to the apachectl script, instead, the http/apache2 file should be used directly. If you are using Ubuntu your Apache will probably be at: /usr/sbin/apache2. If you are using Fedora this will probably be at: /usr/sbin/httpd.

This setup may affect the behavior of the HTTP server in a way that makes impossible or more difficult to reproduce a given bug, if this is the case, you may wish to ask for help in our mailing list and check out Apache's debugging instructions at: https://httpd.apache.org/dev/debugging.html.

## Reporting Issues

If you are facing a configuration issue or if something is not working as you
expect it to be, please use CeleoWAF user’s mailing list. Issues on GitHub
are also welcome, but we prefer to have users question on the mailing list first,
where you can reach an entire community. Also don’t forget to look for an
existing issue before opening a new one.

Lastly, If you are planning to open an issue on GitHub, please don’t forget to tell us the
version of your libceleowaf and the version of the Apache connector you are running.

### Security issue

Please do not publicly report any security issue. Instead, contact us at:
security@celeowaf.org to report the issue. Once the problem is fixed we will provide you with credit for the discovery.

## Feature Request

We would love to discuss any ideas that you may have for a new feature. Please keep in mind this is a community driven project so be sure to contact the community via the mailing list to get feedback first. Alternatively, feel free to open GitHub issues requesting for new features. Before opening a new issue, please check if there is an existing feature request for the desired functionality.

## Packing

Having our packages in distros on time is something we highly desire. Let us know if
there is anything we can do to facilitate your work as a packager.
