# Start with a premade image with R on it from the Rocker group
FROM rocker/r-ver:4.2.0
      
# install some additional packages, then clean it
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    file \
    libcurl4-openssl-dev \
    libedit2 \
    libssl-dev \
    lsb-release \
    psmisc \
    procps \
    wget \
    libxml2-dev \
    libpq-dev \
    libssh2-1-dev \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6  \
    libxrender1 \
    bzip2 \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ 

# install the right R package to use for the app.
RUN Rscript -e "install.packages('shiny')"

# Copy the R shiny app file into the container
COPY app.R /

# The command I want to run when the container starts (this starts the R Shiny app)
ENTRYPOINT ["Rscript","-e","shiny::runApp(port=80,host='0.0.0.0')"]
