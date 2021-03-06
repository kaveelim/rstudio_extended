FROM rocker/verse

RUN sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install libhdf5-dev libgsl-dev

RUN sudo R -e 'install.packages(c("BiocManager","MASS","mgcv","nlme"))' \
 && install2.r --error --deps TRUE devtools \
 && R -e 'devtools::install_github(repo = "hhoeflin/hdf5r")' \
 && R -e 'devtools::install_github(repo = "mojaveazure/loomR", ref = "develop")'

RUN R -e 'BiocManager::install(c( "S4Vectors", "SummarizedExperiment", "SingleCellExperiment", "MAST", "DESeq2", "BiocGenerics", "GenomicRanges", "GenomeInfoDb", "IRanges", "rtracklayer", "monocle", "Biobase", "limma", "multtest"))'

RUN install2.r --error \
 --deps TRUE \
 Seurat \
 conflicted \
 GGally \
 kableExtra \
 knitr \
 survival \
 gridExtra \
 shiny \
 shinyjs \
 plotly \
 DT \
 devtools \
 covr \
 globals \
 && R -e 'BiocManager::install("rhdf5")' \
 && R -e 'devtools::install_github("pachterlab/sleuth")' \
 && R -e 'devtools::install_github("thomasp85/patchwork")' \
 && rm -rf /tmp/downloaded_packages /tmp/*.rds


# Additional R packages
RUN install2.r --error \
 --deps TRUE \
 shinycssloaders \
 waiter \
&& rm -rf /tmp/downloaded_packages
