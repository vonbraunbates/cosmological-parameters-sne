# cosmological-parameters-sne
Cosmological parameter estimation using Type Ia SNe as standard candles

Title: Bayesian inference of cosmological parameters from Type Ia supernovae
Author: Dr. Francesca von Braun-Bates
Date: see repository for last modified date

Original honours thesis
University of Sydney
December 2010

Reconstructed from archived PDF and surviving source material.

## Compilation

With a valid TeX installation:

```sh
    latexmk -pdf main.tex
```

You will need the following packages:

- amssymb
- booktabs
- cleveref
- graphicx
- hyperref
- lscape
- multirow
- subcaption
- threeparttable
- xparse

The thesis useds a custom class file based on `amsbook`: if you have difficulties, start with `amsbook` instead.

## Licence

The thesis text, figures, tables and accompanying documentation are licensed under CC BY 4.0.  For the full text (which is reporduced in `./LICENCE-THESIS`) see https://creativecommons.org/licenses/by/4.0/

The source code is licenced under the MIT Licence, as in `./LICENCE-CODE`.

## Citation

Please cite the following thesis.  If you are using `biblatex` use the `thesis` class:

```bibtex
@thesis{VonBraunBates2010,
  author      = {{von Braun-Bates}, Francesca},
  title       = {Bayesian inference of cosmological parameters from Type Ia supernovae},
  type        = {Honours Thesis},
  institution = {University of Sydney},
  year        = {2010},
  month       = dec,
  note        = {Reconstructed edition available from GitHub}
}
```
Otherwise use `misc`:

```bibtex
@misc{VonBraunBates2010,
  author = {{von Braun-Bates}, Francesca},
  title  = {Bayesian inference of cosmological parameters from Type Ia supernovae,
  year   = {2010},
  note   = {Honours Thesis, University of Sydney}
}
```

