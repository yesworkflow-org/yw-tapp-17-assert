FROM  openskope/paleocar

ARG DEBIAN_FRONTEND=noninteractive

USER root

RUN echo '****** Install Java 8 Runtime Environment'                                                \
 && apt-get -y install default-jre                                                                  \
                                                                                                    \
 && echo '***** Install SVN and GraphViz *****'                                                     \
 && apt-get -y install subversion graphviz                                                          \
                                                                                                    \
 && echo '***** Download yw-prototypes executable jar and create alias *****'                       \
 && mkdir -p ~skope/bin                                                                             \
 && wget -O ~skope/bin/yw.jar https://github.com/yesworkflow-org/yw-prototypes/releases/download/v0.2.1.2/yesworkflow-0.2.1.2-jar-with-dependencies.jar \
 && echo "alias yw='java -jar ~/bin/yw.jar'"  >> ~skope/.bash_aliases                               \
                                                                                                    \
 && echo '***** Download and build XSB 3.6 *****'                                                   \
 && cd ~skope                                                                                       \
 && svn checkout svn://svn.code.sf.net/p/xsb/src/trunk/XSB xsb-3.6                                  \
 && cd xsb-3.6/build                                                                                \
 && ./configure                                                                                     \
 && ./makexsb
    
ENV PATH=$PATH:/home/skope/xsb-3.6/bin

USER skope

CMD  /bin/bash -il
