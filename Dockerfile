# Copyright (c) 2020-2020, Jan Cajthaml <jan.cajthaml@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ---------------------------------------------------------------------------- #

FROM amd64/debian:buster-slim

ENV container docker
ENV LANG C.UTF-8
ENV LC_ALL C
ENV DEBIAN_FRONTEND noninteractive
ENV APT_KEY_DONT_WARN_ON_DANGEROUS_USAGE no
ENV LDFLAGS "-Wl,-z,-now -Wl,-z,relro"
ENV LD_LIBRARY_PATH /usr/lib
ENV PATH="${GOPATH}/bin:${GOROOT}/bin:${PATH}"

RUN \
    echo "installing debian packages" && \
    apt-get update && \
    apt-get -y install --no-install-recommends \
      ca-certificates \
      build-essential \
      wget \
      git \
      tar \
      fakeroot \
      debhelper \
      config-package-dev \
      pkg-config \
      dpkg-sig \
      lintian && \
    \
    apt-get clean autoclean && \
    apt-get autoremove --yes && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
    :

COPY --from=jancajthaml/jq /usr/local/bin/jq /usr/bin/jq

ENTRYPOINT [ "/bin/true" ]
