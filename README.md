Release:

[![Build Status](https://travis-ci.org/TGuillerme/dispRity.svg?branch=release)](https://travis-ci.org/TGuillerme/dispRity)
[![codecov](https://codecov.io/gh/TGuillerme/dispRity/branch/release/graph/badge.svg)](https://codecov.io/gh/TGuillerme/dispRity)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![develVersion](https://img.shields.io/badge/devel%20version-1.2.3-green.svg?style=flat)](https://github.com/TGuillerme/dispRity/tree/release)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1186467.svg)](https://doi.org/10.5281/zenodo.1186467)


Development (master):

[![Build Status](https://travis-ci.org/TGuillerme/dispRity.svg?branch=master)](https://travis-ci.org/TGuillerme/dispRity)
[![codecov](https://codecov.io/gh/TGuillerme/dispRity/branch/master/graph/badge.svg)](https://codecov.io/gh/TGuillerme/dispRity)
[![Project Status: Active - The project has reached a stable, usable state and is being actively developed.](http://www.repostatus.org/badges/latest/active.svg)](http://www.repostatus.org/#active)
[![develVersion](https://img.shields.io/badge/devel%20version-1.2.4-green.svg?style=flat)](https://github.com/TGuillerme/dispRity)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.1186467.svg)](https://doi.org/10.5281/zenodo.1186467)


CRAN:

[![minimal R version](https://img.shields.io/badge/R%3E%3D-3.3.3-6666ff.svg)](https://cran.r-project.org/)
[![cran version](http://www.r-pkg.org/badges/version/dispRity)](https://cran.r-project.org/package=dispRity)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/dispRity)](https://github.com/metacran/cranlogs.app)
![](http://cranlogs.r-pkg.org/badges/dispRity)

### **`dispRity`** is a `R` modular package for measuring disparity from multidimensional matrices.

<a href="https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.13022"><img src="http://tguillerme.github.io/images/OA.png" height="15" widht="15"/></a> 
Check out the [paper](https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.13022) associated with this package.

<a href="https://figshare.com/articles/New_approaches_to_disparity-through-time_analysis/3437546"><img src="http://tguillerme.github.io/images/logo-FS.png" height="15" widht="15"/></a> 
Check out the [presentation](https://figshare.com/articles/New_approaches_to_disparity-through-time_analysis/3437546) or the [video](https://www.youtube.com/watch?v=ZzipKw8W8KQ) of some of the package's novel features.

<!-- Link available until August 2019
https://programme.europa-organisation.com/slides/programme_jointCongressEvolBiology-2018/webconf/683_19082018_1140_antigone1_Thomas_Guillerme_480/index.html
 -->

## Installing dispRity
```r
if(!require(devtools)) install.packages("devtools")
library(devtools)
install_github("TGuillerme/dispRity", ref = "release")
library(dispRity)
```

The following installs the latest release of dispRity (see patch notes below). For the piping hot development version (not recommended), replace the `ref = "release"` option with `ref = "master"`.
If you're using the `master` branch, see the [patch notes](https://github.com/TGuillerme/dispRity/blob/master/NEWS.md) for the latest developments.

The package is available in the [CRAN Task Views in Phylogenetics](https://CRAN.R-project.org/view=Phylogenetics).

[How do I know which version to choose?](https://rawgit.com/TGuillerme/dispRity/master/inst/gitbook/_book/index.html#version)

## Vignettes and manuals

A detailed vignette is available [online](https://rawgit.com/TGuillerme/dispRity/master/inst/gitbook/_book/index.html) or as a [pdf](https://github.com/TGuillerme/dispRity/blob/master/inst/gitbook/_book/dispRity_manual.pdf):

 <a href="https://rawgit.com/TGuillerme/dispRity/master/inst/gitbook/_book/index.html"><img src="http://tguillerme.github.io/images/rawgit.png" height="30"/></a> <a href="https://github.com/TGuillerme/dispRity/blob/master/inst/gitbook/_book/dispRity_manual.pdf"><img src="http://tguillerme.github.io/images/pdf.gif" height="30"/></a> 
 
Otherwise, each functions has a detailed associated manual with examples in `R` (`?which.function`).

Additionally, you can learn more about the structure of `dispRity` objects [here](https://github.com/TGuillerme/dispRity/blob/master/disparity_object.md).


## Latest patch notes
* 2019/03/06 -  v1.2.3

   * `dispRity` objects now contain a metric argument (if a metric was applied). This argument can now be recycled by the appropriate functions (e.g. in `null.test`).
   * `plot.dispRity` argument `observed` can now take a list of arguments to be passed `points()`.
   * `boot.matrix` now makes a error warning message when bootstrapping distance matrices (as suggested by [Dave Bapst](https://github.com/dwbapst/)!).
   * `geomorph.ordination` can now be used to simply create coordinates matrices (no ordination!) with `ordinate = FALSE` argument.
   * better internal handling of error messages.
   * `faster` eigen value estimations in `ellipse.volume` when the argument is left missing.
   * removed internal handling of the `Claddis.ordination` function. This function now uses the brand new version of the `Claddis` package on CRAN (0.3).
   * `plot.dispRity` with option `"box"` now correctly display plot ranges when disparity is an observed distribution.
   * `test.dispRity` handles errors messages more efficiently when disparity is an observed distribution.
   * `summary.dispRity` handles non-bootstrapped distributions display properly.
   * `geomorph.ordination` now converts `"character"` vectors into `"factors"`.
   * `adonis.dispRity` now properly handles complex formulas (with arithmetic signs).
   * `...`  are now properly handled by internal metric testing functions for more accurate error messages.
   * `char.diff` names are now properly protected in the `C` implementation to comply with new `rcheck` requirements.

Previous patch notes and notes for the *next version* can be seen [here](https://github.com/TGuillerme/dispRity/blob/master/NEWS.md).

Authors and contributors
-------

* [Thomas Guillerme](http://tguillerme.github.io)
* [Natalie Cooper](http://nhcooper123.github.io)
* [Mark Puttick](https://puttickbiology.wordpress.com/)

Citations
-------
If you are using this package, please cite the paper:

* Guillerme, T. (**2018**) dispRity: a modular R package for measuring disparity. *Methods in Ecology and Evolution*. [doi:10.1111/2041-210X.13022](https://besjournals.onlinelibrary.wiley.com/doi/abs/10.1111/2041-210X.13022)


<!-- [BibTeX](https://zenodo.org/record/846254/export/hx), [EndNote](https://zenodo.org/record/846254/export/xe), [DataCite](https://zenodo.org/record/846254/export/dcite3), [RefWorks](https://zenodo.org/record/846254/export/xw)-->

To cite the [`dispRity` manual](https://rawgit.com/TGuillerme/dispRity/master/inst/gitbook/_book/dispRity_manual.pdf), please use:

* Guillerme, T. & Cooper, N. (**2018**) dispRity manual. *figshare*. Preprint. 10.6084/m9.figshare.6187337.v1

To cite the [time slicing method](https://onlinelibrary.wiley.com/doi/abs/10.1111/pala.12364) from the `chrono.subsets` function, please use:

* Guillerme, T. & Cooper, N. (**2018**) Time for a rethink: time sub‐sampling methods in disparity‐through‐time analyses. *Palaeontology*, 61: 481-493. [doi:10.1111/pala.12364](https://onlinelibrary.wiley.com/doi/abs/10.1111/pala.12364)


Acknowledgments
-------
Some ideas/functionalities/implementations in this package where implemented following the suggestions of [Natalie Cooper](http://nhcooper123.github.io/), [Graeme Lloyd](http://www.graemetlloyd.com/), [Dave Bapst](https://github.com/dwbapst/), [Andrew Jackson](https://www.tcd.ie/Zoology/people/jacksoan) and [Martin Brazeau](http://www.imperial.ac.uk/people/m.brazeau).

Used in
-------
* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&sciodt=0%2C5&cites=13311379491028410826&scipsc=&q=Fossils+reveal+long-term+continuous+and+parallel+innovation+in+the+sacro-caudo-pelvic+complex+of+the+highly+aquatic+pipid+frogs&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a> 
RO Gómez, CM Pérez-Ben. (**2019**) Fossils Reveal Long-Term Continuous and Parallel Innovation in the Sacro-Caudo-Pelvic Complex of the Highly Aquatic Pipid Frogs. *Frontiers in Earth Science* [DOI: 10.3389/feart.2019.00056](https://www.frontiersin.org/articles/10.3389/feart.2019.00056/full)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&q=Diversity+and+Disparity+of+therocephalia%3A+Macroevolutionary+patterns+through+two+Mass+extinctions&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a> 
HR Grunert, N Brocklehurst, J Fröbisch. (**2019**) Diversity and Disparity of therocephalia: Macroevolutionary patterns through two Mass extinctions. *Scientific Reports* [DOI: 10.1038/s41598-019-41628-w](https://www.nature.com/articles/s41598-019-41628-w#ref-CR55)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&q=Does+exceptional+preservation+distort+our+view+of+disparity+in+the+fossil+record%3F+&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a> 
JT Flannery Sutherland, BC Moon, TL Stubbs, MJ Benton. (**2019**) Does exceptional preservation distort our view of disparity in the fossil record? *Proceedings of the Royal Society B* [DOI: 10.1098/rspb.2019.0091](https://royalsocietypublishing.org/doi/10.1098/rspb.2019.0091#d164727e1)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&sciodt=0%2C5&cites=13311379491028410826&scipsc=&q=Speciation+Rate+Is+Independent+of+the+Rate+of+Evolution+of+Morphological+Size%2C+Shape%2C+and+Absolute+Morphological+Specialization+in+a+Large+Clade+of+Birds&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a> 
NMA Crouch, RE Ricklefs. (**2019**)Speciation Rate Is Independent of the Rate of Evolution of Morphological Size, Shape, and Absolute Morphological Specialization in a Large Clade of Birds *American Naturalist* [DOI: 10.1086/701630](https://www.journals.uchicago.edu/doi/abs/10.1086/701630)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&sciodt=0%2C5&cites=693693665572195425&scipsc=&q=Morphology+and+stable+isotope+analysis+demonstrate+different+structuring+of+bat+communities+in+rainforest+and+savannah+habitats&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a> 
A Monadjem, A Kane, P Taylor, LR Richards, G Hall, S Woodborne. (**2018**) Morphology and stable isotope analysis demonstrate different structuring of bat communities in rainforest and savannah habitats. *Royal Society Open Science* [DOI: 10.1098/rsos.180849](https://royalsocietypublishing.org/doi/full/10.1098/rsos.180849)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&q=Phylogeny%2C+macroevolutionary+trends+and+historical+biogeography+of+sloths%3A+insights+from+a+Bayesian+morphological+clock+analys&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a>
L Varela, PS Tambusso, HG McDonald, RA Fariña (**2018**) Phylogeny, macroevolutionary trends and historical biogeography of sloths: insights from a Bayesian morphological clock analysis. *Systematic Biology*. [DOI: 10.1093/sysbio/syy058](https://academic.oup.com/sysbio/advance-article/doi/10.1093/sysbio/syy058/5098296)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&q=Whole-Genome+Duplication+and+Plant+Macroevolution&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a>
JW Clark, PCJ Donoghue (**2018**) Whole-Genome Duplication and Plant Macroevolution. *Trends in plant science*. [DOI: 10.1016/j.tplants.2018.07.006](https://www.sciencedirect.com/science/article/pii/S1360138518301596)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&sciodt=0%2C5&cites=693693665572195425&scipsc=&q=The+long-term+ecology+and+evolution+of+marine+reptiles+in+a+Jurassic+seaway&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a>
D Foffa, MT Young, TL Stubbs, KG Dexter, SL Brusatte (**2018**) The long-term ecology and evolution of marine reptiles in a Jurassic seaway. *Nature Ecology & Evolution*. [DOI: 10.1038/s41559-018-0656-6](https://www.nature.com/articles/s41559-018-0656-6)

* <a href="https://scholar.google.co.uk/scholar?hl=en&as_sdt=0%2C5&q=Time+for+a+rethink%3A+time+sub%E2%80%90sampling+methods+in+disparity%E2%80%90through%E2%80%90time+analyses&btnG="><img src="http://tguillerme.github.io/images/649298-64.png" height="15" widht="15"/></a>
T Guillerme, N Cooper (**2018**) Time for a rethink: time sub‐sampling methods in disparity‐through‐time analyses. *Palaeontology*. 61: 481-493. [DOI: 10.1111/pala.12364](https://onlinelibrary.wiley.com/doi/abs/10.1111/pala.12364)
