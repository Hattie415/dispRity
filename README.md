[![Build Status](https://travis-ci.org/TGuillerme/dispRity.svg?branch=release)](https://travis-ci.org/TGuillerme/dispRity)
[![codecov](https://codecov.io/gh/TGuillerme/dispRity/branch/release/graph/badge.svg)](https://codecov.io/gh/TGuillerme/dispRity)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.55646.svg)](https://doi.org/10.5281/zenodo.55646)


**dispRity** is a `R` package for summarising ordinated matrices (e.g. MDS, PCA, PCO or PCoA analysis).

<a href="https://figshare.com/articles/New_approaches_to_disparity-through-time_analysis/3437546"><img src="http://tguillerme.github.io/images/logo-FS.png" height="15" widht="15"/></a> 
Check out the [presentation](https://figshare.com/articles/New_approaches_to_disparity-through-time_analysis/3437546) or the [video](https://www.youtube.com/watch?v=ZzipKw8W8KQ) of some of the package's novel features.

## Installing dispRity
```r
if(!require(devtools)) install.packages("devtools")
library(devtools)
install_github("TGuillerme/dispRity", ref = "release")
library(dispRity)
```

The following installs the latest release of dispRity (see patch notes below). For the piping hot development version (not recommended), replace the `ref = "release"` option with `ref = "master"`. If you're using the `master` branch, see the [patch notes](https://github.com/TGuillerme/dispRity/blob/master/patch_notes.md) for the latest developments.

> Installation problems? Make sure you're using the latest R version (or at least `> 4.0`) and try again.

#### Vignettes

See the package manual online [here](https://rawgit.com/TGuillerme/dispRity/master/inst/gitbook/_book/index.html) or download the pdf version [here](https://rawgit.com/TGuillerme/dispRity/master/inst/gitbook/_book/index.html)

Additionally, you can learn more about the structure of `dispRity` objects [here](https://github.com/TGuillerme/dispRity/blob/master/disparity_object.md).

##### Patch notes
* 2017/06/19 - v0.3.9  (version 0.4 pre-release) <!--*user friendly*-->
  * Entirely rewritten manual!
  * *New* function: `Claddis.ordination` for automatically ordinating data from `Claddis`!
  * *New* function: `char.diff` for calculating character differences and associated plot function (`plot.char.diff`)
  * *New* function: `merge.subsamples` for... merging subsamples!
  * *New* wrapping functions: `dispRity.through.time` and `dispRity.per.group` now runs easy default disparity analysis.
  * Input ordinated matrices do not need to be of maximum size `n*(n-1)`. Bigger matrices now only trigger a warning.
  * **Changed name**: `series` as a part of `dispRity` objects is now changed to `subsamples` throughout the whole package.
  * **Changed name**: `time.series` is now renamed `time.subsamples`.
  * **Changed name**: `get.subsamples.dispRity` is now renamed `get.subsamples`.
  * **Modified function**: `cust.series` is now renamed `custom.subsamples` (to avoid confusion with `custard.subsamples`!). Its `factor` argument has been changed to `groups` and can now take a simple list.
  * Minor bug correction for optional arguments passed to `plot`.
  * `variances`, `ranges` and `centroids` are now simplified for speed. The optional arguments data cleaning are now passed to `make.metric`.
  
Previous patch notes and notes for the *next version* can be seen [here](https://github.com/TGuillerme/dispRity/blob/master/patch_notes.md).

#### Implemented metrics
A list of implemented metrics is available [here](https://github.com/TGuillerme/dispRity/blob/master/doc/dispRity-metrics.Rmd). Note, however, that the whole purpose of `dispRity`'s architecture is to allow users to implement their own metrics, so this list is not exhaustive.

Authors
-------

* [Thomas Guillerme](http://tguillerme.github.io)
* [Natalie Cooper](http://nhcooper123.github.io)
* [Mark Puttick](https://puttickbiology.wordpress.com/)

Citation
-------
If you are using this package, please cite the following Zenodo DOI (an associated paper will be added soon):

* Guillerme, T. (**2016**). dispRity: a package for measuring disparity in R. Zenodo. 10.5281/zenodo.55646

 [BibTeX](https://zenodo.org/record/55646/export/hx), [EndNote](https://zenodo.org/record/55646/export/xe), [DataCite](https://zenodo.org/record/55646/export/dcite3), [RefWorks](https://zenodo.org/record/55646/export/xw)

Acknowledgments
-------
Some ideas/functionalities/implementations in this package where implemented following the suggestions of [Natalie Cooper](http://nhcooper123.github.io/), [Graeme Lloyd](http://www.graemetlloyd.com/), [Dave Bapst](http://webpages.sdsmt.edu/~dbapst/), [Andrew Jackson](http://www.tcd.ie/Zoology/research/research/theoretical/andrewjackson.php) and [Martin Brazeau](http://www.imperial.ac.uk/people/m.brazeau).
