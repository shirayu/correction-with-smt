# correction-with-smt

Scripts for error correction with SMT


# Get started
## Install following tools
- You can get links [here](http://www.statmt.org/)
- This Information may not be latest version.

- Suppose the Moses directory is ``/moses``
- First, install GIZA++
    - After ``make``, binaries appear at giza-pp/GIZA++-v2
    - Copy them ``GIZA++ ./plain2snt.out ./snt2cooc.out ./snt2plain.out trainGIZA++.sh mkcls`` to ``/moses/giza``
- Second, install SRILM
    - ``./regenerate-makefiles.sh && ./configure --prefix=/moses/irstlm ``
    - After ``make``, binaries appear at giza-pp/GIZA++-v2
- Last, install Moses
    - You have to install boost
    - ``./bjam --with-irstlm=/moses/irstlm/ --with-giza=/moses/giza/ -j6``
    - You should designate parametes with their absolute paths
    - Check you got no errors.

## Prepare data
- Prepare an original file ``data.incor`` and a corrected file ``data.corr``

## Training
- ``sh ./train.sh /moses/ /path/to/data  /path/to/work``

## Test
- ``sh ./test.sh /moses/ /path/to/work/model ./input.txt ./out.txt``



# References
- [Scripts written by Tomoya Mizumoto for Error Detection and Correction Workshop 2012 held in Japan](http://code.google.com/p/edcw2012-open/source/browse/?name=NAIST#git%2FNAIST)
- [Moses web site](http://www.statmt.org/moses/)

# License
- GPL v3


