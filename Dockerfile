FROM ubuntu:xenial
MAINTAINER <alik@robarts.ca>

RUN mkdir -p /src/install_scripts
COPY install_scripts/ /src/install_scripts


ENV DEBIAN_FRONTEND noninteractive
RUN bash /src/install_scripts/00.install_basics_sudo.sh
RUN bash /src/install_scripts/10.install_afni_fsl_sudo.sh
RUN bash /src/install_scripts/16.install_ants_by_binary.sh /opt
RUN bash /src/install_scripts/25.install_niftyreg_by_source.sh /opt
RUN bash /src/install_scripts/22.install_minc_by_deb.sh /opt


#remove all install scripts
RUN rm -rf /src




#fsl
ENV FSLDIR /usr/share/fsl/5.0
ENV POSSUMDIR $FSLDIR
ENV PATH /usr/lib/fsl/5.0:$PATH
ENV FSLOUTPUTTYPE NIFTI_GZ
ENV FSLMULTIFILEQUIT TRUE
ENV FSLTCLSH /usr/bin/tclsh
ENV FSLWISH /usr/bin/wish
ENV FSLBROWSER /etc/alternatives/x-www-browser
ENV LD_LIBRARY_PATH /usr/lib/fsl/5.0:${LD_LIBRARY_PATH}


#ants
ENV PATH /opt/ants:$PATH
ENV ANTSPATH /opt/ants

#niftyreg
ENV LD_LIBRARY_PATH /opt/niftyreg-1.3.9/lib:$LD_LIBRARY_PATH 
ENV PATH /opt/niftyreg-1.3.9/bin:$PATH

#minc
ENV MINC_TOOLKIT /opt/minc/1.9.15
ENV MINC_TOOLKIT_VERSION "1.9.15-20170529"
ENV PATH /opt/minc/1.9.15/bin:/opt/minc/1.9.15/pipeline:${PATH}
ENV PERL5LIB /opt/minc/1.9.15/perl:/opt/minc/1.9.15/pipeline:${PERL5LIB}
ENV LD_LIBRARY_PATH /opt/minc/1.9.15/lib:/opt/minc/1.9.15/lib/InsightToolkit:${LD_LIBRARY_PATH}
ENV MNI_DATAPATH /opt/minc/1.9.15/share
ENV MINC_FORCE_V2 1
ENV MINC_COMPRESS 4
ENV VOLUME_CACHE_THRESHOLD -1
ENV MANPATH /opt/minc/1.9.15/man:${MANPATH}


