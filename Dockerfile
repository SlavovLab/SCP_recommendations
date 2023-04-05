FROM bioconductor/bioconductor_docker

COPY install_dependencies.R install_dependencies.R

RUN Rscript install_dependencies.R >> installation.log
