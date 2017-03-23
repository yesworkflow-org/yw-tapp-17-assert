FROM  openskope/paleocar:0.1.0

ARG DEBIAN_FRONTEND=noninteractive

USER root

COPY ./bin /home/skope/bin

RUN echo '****** Install Java 8 Runtime Environment'                                                \
 && apt-get -y install default-jre                                                                  \
                                                                                                    \
 && echo '***** Install SVN *****'                                                                  \
 && apt-get -y install subversion                                                                   \
                                                                                                    \
 && echo '***** Install GraphViz *****'                                                             \
 && apt-get -y install subversion graphviz                                                          \
                                                                                                    \
 && echo '***** Download and build XSB 3.6 *****'                                                   \
 && cd ~skope                                                                                       \
 && svn checkout svn://svn.code.sf.net/p/xsb/src/trunk/XSB xsb-3.7                                  \
 && cd xsb-3.7/build                                                                                \
 && ./configure                                                                                     \
 && ./makexsb                                                                                       \
                                                                                                    \
 && echo '***** Download yw-prototypes executable jar *****'                                        \
 && wget -O ~skope/bin/yw.jar https://github.com/yesworkflow-org/yw-prototypes/releases/download/v0.2.1.2/yesworkflow-0.2.1.2-jar-with-dependencies.jar

ENV YW_JAR=/home/skope/bin/yw.jar
ENV PATH=$PATH:/home/skope/bin:/home/skope/xsb-3.6/bin

USER skope

CMD  /bin/bash -il
