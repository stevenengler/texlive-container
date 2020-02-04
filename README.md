# TeX Live Docker Container

This package provides a Docker image configuration and a small script that lets you run your LaTeX programs in a container. The container includes TeX Live 2019 and [Rubber](https://launchpad.net/rubber/). The container includes many TeX Live packages that I found useful, but also tries to keep the size of the image from growing too large (the final Docker image will be about 1.3 GB). An example Makefile is also provided if you wish to use it, and lets you automatically rebuild the pdf every time the TeX file is updated.

## Installing

1) Clone the repository if you haven't already.

    ```bash
    git clone https://github.com/stevenengler/texlive-container
    ```

2) Build the Docker image (you must have Docker installed).

    ```bash
    cd texlive-container
    sudo docker build --tag texlive-container .
    ```

## Compiling your TeX file

Simply run your chosen LaTeX program using the `start.sh` script.

```bash
./start.sh pdflatex document.tex
./start.sh rubber --pdf document.tex
./start.sh rubber --pdf --clean document.tex
```

Note that the TeX document must be in the current working directory or a subdirectory, but you can run the `start.sh` script from any directory you like.

```bash
cd /tmp/example-document
vim document.tex
~/code/texlive-container/start.sh pdflatex document.tex
evince document.pdf
```

For more advanced usage, an example Makefile is provided. This Makefile allows you to build the pdf with `make`, remove the generated files with `make clean`, and automatically rebuild the pdf every time the TeX file is updated using `make watch`.
