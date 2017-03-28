###########################################################
#rde : rails development environment
#  how to build :
#    su
#    nohup sudo docker build -t beautifulsky.xyz:5000/rde:ruby23-centos7 . &
#
###########################################################
FROM centos:7

###########################################################
# repo
###########################################################

COPY wandisco.repo /etc/yum.repos.d/wandisco.repo
RUN rpm --import http://opensource.wandisco.com/RPM-GPG-KEY-WANdisco \
 && yum install -y epel-release

###########################################################
# subversion,git
###########################################################

ENV GIT_USER_NAME=takazoo \
    GIT_USER_EMAIL=takazoo@gmail.com

RUN yum -y install subversion git \
 && git config --global user.name "${GIT_USER_NAME}" \
 && git config --global user.email ${GIT_USER_EMAIL} \
 && git config --global push.default matching \
 && git config --global alias.co checkout \
 && git config --global alias.ci commit

###########################################################
# ruby
###########################################################

ENV RUBY_MAJOR=2.3 \
    RUBY_VERSION=2.3.3

RUN yum -y groupinstall "Development Tools"
RUN yum -y install openssl-devel readline-devel zlib-devel curl-devel libyaml-devel sqlite-devel postgresql-devel \
 && yum -y install tar 
RUN cd /usr/local/src \
 && curl -O http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz \
 && tar zxvf ruby-$RUBY_VERSION.tar.gz \
 && cd ruby-$RUBY_VERSION \
 && ./configure --disable-install-doc \
 && make \
 && make install
RUN cd /usr/local/src/ruby-${RUBY_VERSION}/ext/zlib \
 && ruby extconf.rb \
 && cd /usr/local/src/ruby-${RUBY_VERSION} \
 && ./configure --disable-install-doc \
 && make \
 && make install

###########################################################
# emacs
###########################################################

RUN yum -y install emacs

###########################################################
# rails
###########################################################

RUN gem install rails -v 4.2.2 \
 && yum install -y nodejs

###########################################################
# heroku
###########################################################

RUN yum install -y wget sudo which \
 && wget -qO- https://toolbelt.heroku.com/install.sh | sh \
 && echo 'PATH="/usr/local/heroku/bin:$PATH"' >> ~/.bash_profile 

###########################################################
# Japanese Locale
###########################################################
RUN rm -f /etc/rpm/macros.image-language-conf && \
    sed -i '/^override_install_langs=/d' /etc/yum.conf && \
    yum -y reinstall glibc-common \
 && yum clean all

ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"
