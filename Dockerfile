FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install LaTeX, LuaLaTeX, necessary tools, and fonts
RUN apt-get update && apt-get install -y --no-install-recommends \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-luatex \
    texlive-science \
    latexmk \
    ca-certificates \
    make \
    wget \
    unzip \
    fontconfig \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Manually install Libertinus fonts
RUN mkdir -p /usr/share/fonts/opentype/libertinus && \
    cd /usr/share/fonts/opentype/libertinus && \
    wget https://github.com/alerque/libertinus/releases/download/v7.040/Libertinus-7.040.zip && \
    unzip Libertinus-7.040.zip && \
    fc-cache -fv
    
COPY . /workspace

WORKDIR /workspace

ENTRYPOINT ["latexmk", "-lualatex", "-interaction=nonstopmode", "-halt-on-error", "main.tex"]



