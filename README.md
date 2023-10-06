Isomorphism -- Mathematics of Programming
====

2023/10

This book introduces the mathematics behind computer programming.

<img src="https://user-images.githubusercontent.com/332938/245659299-fa556453-2f5f-4771-ade1-0a0c1adf499c.png" width="400">

Contents
--------

The book can be downloaded in English ([EN](https://github.com/liuxinyu95/unplugged/files/11070580/unplugged-en.pdf)). The 1st edition in Chinese ([中文](https://book.douban.com/subject/36347220/)) was published in 2023 ([中文样章](https://github.com/liuxinyu95/unplugged/files/11183276/nat-zh-cn.pdf)).

- Preface
- Chapter 1, Natural numbers. Peano Axiom, list and folding;
- Chapter 2, Recursion. Euclidean algorithm, Lambda calculus, and Y-combinator;
- Chapter 3, Symmetry. Group, Ring, and Field. Galois Theory;
- Chapter 4, Category theory and type system;
- Chapter 5, Deforest. Build-fold fusion law, optimization, and algorithm deduction;
- Chapter 6, Infinity. Set theory, Infinity and stream;
- Chapter 7, Logic paradox, Gödel's incompleteness theorems, and Turing halting problem.
- Answers to the exercise.

Install
--------

To build the book in PDF format from the sources, you need
the following software pre-installed.

- TeXLive, The book is built with LuaLaTeX, an extended version of TeX.

### Install TeXLive

In Debian/Ubuntu like Linux environment, do **NOT** install the TeXLive through apt-get. Go to TeXLive [official site](https://tug.org/texlive/) to download the setup script.

```bash
$ wget http://mirror.ctan.org/systems/texlive/tlnet/install-tl.zip
$ unzip install-tl.zip
$ cd install-tl
$ sudo ./install-tl -gui text -repository http://mirror.ctan.org/systems/texlive/tlnet
```

In Windows, TeXLive provide a [gui based installer](https://tug.org/texlive/), in Mac OS X, there's a [MacTeX](https://www.tug.org/mactex/).

### Customize font

The default build supports Linux, Mac OS X, and Windows. You can install additional font (like [Noto CJK](https://github.com/notofonts/noto-cjk/)) typesetting (see `prelude.sty`). Some system fonts, e.g. STKaiti, were moved to `/System/Library/AssetsV2/com_apple_MobileAsset_Font7` in Mac OS X, you need add the path to the local TeXLive configuration:

```bash
sudo tlmgr conf texmf OSFONTDIR /System/Library/AssetsV2/com_apple_MobileAsset_Font7
```

### Others

You need the GNU make tool, in Debian/Ubuntu like Linux, it can be installed through the apt-get command:

```bash
$ sudo apt-get install build-essential
```

In Windows, you can install the MSYS for it. In Mac OS X, please install the developer tool from this command line:

```bash
$ xcode-select --install
```

### Build the PDF book

enter the folder contains the book TeX manuscript, run

```bash
$ make
```

This will generate unplugged-en.pdf and unplugged-zh-cn.pdf. If you only need the English version for example, you can run `make en` instead. Run `make force-en` to force build the book.

--

LIU Xinyu
