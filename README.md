# Photoname
Script for consistent naming of my photos I take. More info about this [naming convention](http://localhost:4000/bullet-proof-photo-naming-strategy/).
This script is part of my photo workflow of which you can read more about in [this blog article](https://www.sitebase.be/my-photo-management-workflow/).

## Using the script
```
wget https://raw.githubusercontent.com/Sitebase/photoname/master/photoname
chmod +x photoname
./photoname dir/myfile.jpg
```

## Comptible platforms
* Tested on Mac OSX ![Mac OSX Test](https://github.com/sitebase/photoname/workflows/MacOSX/badge.svg)
* Tested on Ubuntu ![Ubuntu Test](https://github.com/sitebase/photoname/workflows/Ubuntu/badge.svg)

*Unit test are run each time something is pushed to this repository. Tests are run both on latest Mac OSX and Ubuntu.*

## Unit Testing
I've added unit tests to verify changes to the script are working as expected. If you find any files producing weird results. Feel free to create an issue and attach your photo so I can do some testing with it.

>./test/run.sh
