FROM rocker/r-ver:4.1.1
RUN apt-get update && apt-get install -y  git-core libcurl4-openssl-dev libgit2-dev libicu-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl', Ncpus = 4)" >> /usr/local/lib/R/etc/Rprofile.site
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'install.packages("renv")'
RUN R -e 'renv::restore()'
RUN R -e 'remotes::install_local(upgrade="never", force = TRUE)'
#RUN rm -rf /build_zone
EXPOSE 80
CMD R -e "options('shiny.port'=80,shiny.host='0.0.0.0');rege::run_app()"
