{
  python2Packages,
  lib,
  fetchFromGitHub,
  fetchPypi,
  libffi,
  doCheck ? false,
}: let
  six = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "six";
    version = "1.9.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-4kBSQR/E+9H2cmNVN8P8IzDZSBsYwDF2lbRiWVEskdU=";
    };
  };
  txaio = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "txaio";
    version = "1.1.0";
    propagatedBuildInputs = [six];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-Ox8xLXxDV85wuSxD9vM1QZtN2xYGg5VS6CmP/qw2bdo=";
    };
  };
  autobahn = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "autobahn";
    version = "0.10.9";
    propagatedBuildInputs = [txaio];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-P+zB4qJqBCESjdz7Tld/C8Zp3WXQ4P2tHHc5ZcvO91o=";
    };
  };
  linecache2 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "linecache2";
    version = "1.0.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-Syb/TnEQ23butvWntkqCYjg51ZXCA47tpmLyott46Xw=";
    };
  };
  traceback2 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "traceback2";
    version = "1.4.0";
    propagatedBuildInputs = [linecache2];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-BazGegmYDC7P7dNCP3rgEEg57MtV/GRXc+HKoJUcMDA=";
    };
  };
  argparse = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "argparse";
    version = "1.3.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-s6eaI9N7WgL6pVC5LLu+vrSqHXfmScPrOcGav1Ji2gQ=";
    };
  };
  unittest2 = python2Packages.buildPythonPackage rec {
    # see fork https://github.com/garbas/unittest2
    inherit doCheck;
    pname = "unittest2";
    version = "1.1.0";
    postPatch = ''
      # substituteInPlace setup.py --replace-fail "VERSION = late_version()" "VERSION = '${version}'"
      sed -i '/import os\|import sys/d' setup.py
      sed -i '/class late_version:/,/VERSION = late_version()/c\VERSION = "${version}"' setup.py
      sed -i '/readme = os.path.join/,/LONG_DESCRIPTION = open(readme).read()/c\LONG_DESCRIPTION = ""' setup.py
      sed -i "/params\['test_suite'\] = 'unittest2.collector'/d" setup.py
    '';
    propagatedBuildInputs = [six traceback2 argparse];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-IogqDkGMKE4fcYqCKzsCKUTVPS2QjhaQsxmp0+ssBXk=";
    };
  };
  markupsafe = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "MarkupSafe";
    version = "1.1.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-KYcukoOXZeVGgou3dUpoxBjZJ80GT9Rwj6uf6ci7EWs=";
    };
  };
  jinja2 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "Jinja2";
    version = "2.11.3";
    propagatedBuildInputs = [markupsafe];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-ptWEM94K6AA0fKsfowQ867q+i6qdKeZo8cdoy4ejM8Y=";
    };
  };
  werkzeug = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "Werkzeug";
    version = "1.0.1";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-bICx5a02ZSkOo5MguR4b4eDV9gZSuWSjBwIW3oPS5Hw=";
    };
  };
  ipaddress = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "ipaddress";
    version = "1.0.22";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-sUbHUepFytYYjdbPLZt1f29PjW/7lqAj5vLibuoCpyw=";
    };
  };
  pyasn1 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "pyasn1";
    version = "0.4.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-+4FiLY81CfACawaD/pD+onvnKE04JqXy7fl/aRUasPw=";
    };
  };
  pyasn1-modules = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "pyasn1-modules";
    version = "0.2.2";
    propagatedBuildInputs = [pyasn1];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-oM8+GELnxg/el8si0nXrb5Uk9cUlBIniklKd6EFBdUc=";
    };
  };
  enum34 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "enum34";
    version = "1.1.6";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-itjEeDv2He10Unv/tI7ZtUFmaF5CMDhqntmxJ54t9bE=";
    };
  };
  asn1crypto = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "asn1crypto";
    version = "0.24.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-nVwgRBuvDLYKSsNMxEfGwYkCS2tMbNeHcDT0llxGTkk=";
    };
  };
  pycparser = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "pycparser";
    version = "2.18";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-majKA+KYUdlmFq0EBLSq19nuFvJcn5cIoR+vKBD3siY=";
    };
  };
  cffi_1_11_5 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "cffi";
    version = "1.11.5";
    buildInputs = [libffi];
    propagatedBuildInputs = [enum34 six asn1crypto ipaddress pycparser];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-6Q8XmA5qsPPC83MOVtH+m8uhiR7upYlm6J01JJLMdPQ=";
    };
  };
  idna = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "idna";
    version = "2.7";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-aEo4pvkDwdcdbV+sBmtY13aK9N4rgy5CbsecMNqpShY=";
    };
  };
  cryptography_2_4_2 = python2Packages.buildPythonPackage rec {
    pname = "cryptography";
    version = "2.4.2";
    postPatch = ''
      cat > setup.py <<EOF
      #!/usr/bin/env python

      from __future__ import absolute_import, division, print_function

      from distutils.command.build import build
      import pkg_resources
      import setuptools
      from setuptools import find_packages, setup
      from setuptools.command.test import test

      about = {}
      with open("src/cryptography/__about__.py") as f:
          exec(f.read(), about)

      VECTORS_DEPENDENCY = "cryptography_vectors=={}".format(about['__version__'])
      setup_requirements = ["cffi>=1.7,!=1.11.3"]
      test_requirements = [
          "pytest>=3.6.0,!=3.9.0,!=3.9.1,!=3.9.2",
          "pretend",
          "iso8601",
          "pytz",
          "hypothesis>=1.11.4,!=3.79.2",
      ]

      class PyTest(test):
          def finalize_options(self):
              test.finalize_options(self)
              self.test_args = []
              self.test_suite = True

          def run_tests(self):
              import pytest
              errno = pytest.main(["tests"])
              raise SystemExit(errno)

      setup(
          name=about["__title__"],
          version=about["__version__"],
          description=about["__summary__"],
          long_description=open("README.rst").read(),
          license=about["__license__"],
          url=about["__uri__"],
          author=about["__author__"],
          author_email=about["__email__"],
          classifiers=[
              "Development Status :: 5 - Production/Stable",
              "Intended Audience :: Developers",
              "License :: OSI Approved :: Apache Software License",
              "License :: OSI Approved :: BSD License",
              "Natural Language :: English",
              "Operating System :: MacOS :: MacOS X",
              "Operating System :: POSIX",
              "Operating System :: POSIX :: BSD",
              "Operating System :: POSIX :: Linux",
              "Operating System :: Microsoft :: Windows",
              "Programming Language :: Python",
              "Programming Language :: Python :: 2",
              "Programming Language :: Python :: 2.7",
              "Programming Language :: Python :: 3",
              "Programming Language :: Python :: 3.4",
              "Programming Language :: Python :: 3.5",
              "Programming Language :: Python :: 3.6",
              "Programming Language :: Python :: 3.7",
              "Programming Language :: Python :: Implementation :: CPython",
              "Programming Language :: Python :: Implementation :: PyPy",
              "Topic :: Security :: Cryptography",
          ],
          package_dir={"": "src"},
          packages=find_packages(where="src", exclude=["_cffi_src", "_cffi_src.*"]),
          include_package_data=True,
          python_requires='>=2.7,!=3.0.*,!=3.1.*,!=3.2.*,!=3.3.*',
          install_requires=[
              "idna >= 2.1",
              "asn1crypto >= 0.21.0",
              "six >= 1.4.1",
          ] + setup_requirements,
          tests_require=test_requirements,
          extras_require={
              ":python_version < '3'": ["enum34", "ipaddress"],
              "test": test_requirements,
              "docs": [
                  "sphinx >= 1.6.5,!=1.8.0",
                  "sphinx_rtd_theme",
              ],
              "docstest": [
                  "doc8",
                  "pyenchant >= 1.6.11",
                  "readme_renderer >= 16.0",
                  "sphinxcontrib-spelling >= 4.0.1",
              ],
              "pep8test": [
                  "flake8",
                  "flake8-import-order",
                  "pep8-naming",
              ],
          },
          zip_safe=False,
          ext_package="cryptography.hazmat.bindings",
          cmdclass={"test": PyTest},
      )
      EOF
    '';
    propagatedBuildInputs = [enum34 six asn1crypto ipaddress cffi_1_11_5 idna];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-BaYFLGqfF/94unj45usdd30l2zt2M0OhromnqGcDht0=";
    };
  };
  attrs_18_1_0 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "attrs";
    version = "18.2.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-EMv24n286MMIB8rwVsjrUJF+Dqr+hjR2cbVyVABsPmk=";
    };
  };
  service-identity = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "service-identity";
    version = "18.1.0";
    postPatch = ''
      cat > setup.py <<EOF
      from setuptools import find_packages, setup

      NAME = "service_identity"
      VERSION = "${version}"
      INSTALL_REQUIRES = [
          "attrs>=16.0.0",
          "ipaddress; python_version<'3.3'",
          "pyasn1-modules",
          "pyasn1",
          "cryptography",
      ]
      EXTRAS_REQUIRE = {
          "idna": ["idna"],
          "tests": ["coverage>=4.2.0", "pytest"],
          "docs": ["sphinx"],
      }
      EXTRAS_REQUIRE["dev"] = (
          EXTRAS_REQUIRE["tests"] + EXTRAS_REQUIRE["docs"] + ["idna", "pyOpenSSL"]
      )
      setup(
          name=NAME,
          version=VERSION,
          packages=find_packages(),
          install_requires=INSTALL_REQUIRES,
          extras_require=EXTRAS_REQUIRE,
          zip_safe=False,
      )
      EOF
    '';
    propagatedBuildInputs = [ipaddress pyasn1-modules cryptography_2_4_2 attrs_18_1_0];
    src = fetchFromGitHub {
      owner = "pyca";
      repo = pname;
      tag = version;
      hash = "sha256-+iN9mhXlSTV/DnRC/fL7ooaflxTiwM1RFUdX/4vDeys=";
    };
  };
  cffi_1_14_4 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "cffi";
    version = "1.14.4";
    buildInputs = [libffi];
    propagatedBuildInputs = [pycparser];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-GkZcvpin/TkdR9zkuPfluSHmzYBe9CHQT19muo8GCGw=";
    };
  };
  cryptography_3_3_1 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "cryptography";
    version = "3.3.1";
    postPatch = ''
      cat > setup.py <<EOF
      from setuptools import find_packages, setup

      setup(
          name="cryptography",
          version="${version}",
          description="A cryptography package",
          long_description="""A detailed description of the package.""",
          long_description_content_type="text/x-rst",
          license="Apache-2.0 OR BSD",
          url="https://example.com",
          author="Author Name",
          author_email="author@example.com",
          classifiers=[
              "Development Status :: 5 - Production/Stable",
              "Intended Audience :: Developers",
              "License :: OSI Approved :: Apache Software License",
              "License :: OSI Approved :: BSD License",
              "Operating System :: OS Independent",
              "Programming Language :: Python :: 2",
              "Programming Language :: Python :: 2.7",
              "Programming Language :: Python :: 3",
              "Programming Language :: Python :: 3.6",
              "Programming Language :: Python :: 3.7",
              "Programming Language :: Python :: 3.8",
              "Programming Language :: Python :: 3.9",
              "Programming Language :: Python :: Implementation :: CPython",
          ],
          package_dir={"": "src"},
          packages=find_packages(where="src", exclude=["_cffi_src", "_cffi_src.*"]),
          include_package_data=True,
          python_requires=(
              ">=2.7,!=3.0.*,!=3.1.*,!=3.2.*,!=3.3.*,!=3.4.*,!=3.5.*"
          ),
          install_requires=["six >= 1.4.1", "cffi>=1.12"],
          extras_require={
              ":python_version < '3'": ["enum34", "ipaddress"],
              "test": [
                  "pytest>=3.6.0,!=3.9.0,!=3.9.1,!=3.9.2",
                  "pretend",
                  "iso8601",
                  "pytz",
                  "hypothesis>=1.11.4,!=3.79.2",
              ],
              "docs": [
                  "sphinx >= 1.6.5,!=1.8.0,!=3.1.0,!=3.1.1",
                  "sphinx_rtd_theme",
              ],
              "ssh": ["bcrypt >= 3.1.5"],
          },
          zip_safe=False,
          ext_package="cryptography.hazmat.bindings",
      )
      EOF
    '';
    propagatedBuildInputs = [enum34 six ipaddress cffi_1_14_4];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-fhd+S+ot6TelhLE2RcqzLyXj2W/AvEpM+Zwn3HdoK+Y=";
    };
  };
  pyopenssl = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "pyOpenSSL";
    version = "20.0.1";
    propagatedBuildInputs = [six cryptography_3_3_1];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-TCMcdZVDugJWD80kgMSNzsTa40ydp9N0fFCCJ+BiS1E=";
    };
  };
  hyperlink = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "hyperlink";
    version = "19.0.0";
    propagatedBuildInputs = [idna];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-QojjRwXaB3+toREaJKCqCLsedmmcnOSYdq9yJEGEVlQ=";
    };
  };
  constantly = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "constantly";
    version = "15.1.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-WGNy65IFmHPinrpPneyDgVQbTTg0ZgcH+vi6WRRt/DU=";
    };
  };
  attrs_19_3_0 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "attrs";
    version = "19.3.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-97fOFlcP6ZZazW0wEBoo9i+0p/npJrO7ybYfiwQkfnI=";
    };
  };
  incremental = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "incremental";
    version = "17.5.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-e3UWlqrzbuv6tTfkWJKeGURgBRzK0nnHK3VaFn7r1LM=";
    };
  };
  automat = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "Automat";
    version = "20.2.0";
    propagatedBuildInputs = [attrs_19_3_0 six];
    postPatch = ''
      substituteInPlace setup.py \
      --replace-fail "try:" "##REMOVED##" \
      --replace-fail "from m2r import parse_from_file" "##REMOVED##" \
      --replace-fail "long_description = parse_from_file('README.md')" "##REMOVED##" \
      --replace-fail "except(IOError, ImportError):" "##REMOVED##" \
      --replace-fail "    print(\"\\n\\n!!! m2r not found, long_description is bad, don't upload this to PyPI !!!\\n\\n\")" "##REMOVED##" \
      --replace-fail "    import io" "##REMOVED##" \
      --replace-fail "    long_description = io.open('README.md', encoding=\"utf-8\").read()" "long_description = \"\""
      substituteInPlace setup.py --replace-fail "use_scm_version=True" "version = '${version}'"
      substituteInPlace setup.py --replace-fail "packages=find_packages(exclude=[])" "packages=[\"automat\"]"
      substituteInPlace setup.py \
      --replace-fail "        'setuptools-scm'," "" \
      --replace-fail "        'm2r'," ""
    '';
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-eXmAPHRhDhHvDA1oopQrFS31LaVTNuDJ1Y2vGDHL3zM=";
    };
  };
  zope-interface = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "zope.interface";
    version = "5.0.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-naVCqo+xNnHjqgNyLPR53DYRpOdn3iVmKdYJvLLpkoU=";
    };
  };
  pyhamcrest = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "PyHamcrest";
    version = "1.10.1";
    propagatedBuildInputs = [six];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-964Z3f1x8RpCG87JYI1wjA+rgW25i1H9vGcqbZmjCHQ=";
    };
  };
  twisted_20_3_0 = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "Twisted";
    version = "20.3.0";
    buildInputs = [python2Packages.typing];
    propagatedBuildInputs = [hyperlink constantly attrs_19_3_0 incremental automat zope-interface pyhamcrest];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-1yxVtdVuF2VjuR0RlS0TsBr4clxiPkmNtVB7ZhT8HhA=";
      extension = "tar.bz2";
    };
  };
  characteristic = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "characteristic";
    version = "14.3.0";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-3taNTkJBFe1E5cg8KpAaC2FXqVkHnXWR2SEG/9Oto4A=";
    };
  };
  tubes = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "Tubes";
    version = "0.2.0";
    propagatedBuildInputs = [twisted_20_3_0 characteristic];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-jVX/2kwzLe2jmb+JozWsfOowf8j2v9if7gEKAMR74Wk=";
    };
  };
  klein = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "klein";
    version = "20.6.0";
    buildInputs = [python2Packages.typing];
    propagatedBuildInputs = [twisted_20_3_0 werkzeug tubes enum34];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-ZYS5zf9JWbnc7pWhwcIAEPUhoqEsT/PN2LkDqbDpk/Y=";
    };
  };
  ujson = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "ujson";
    version = "2.0.3";
    postPatch = ''
      cat > setup.py <<EOF
      from glob import glob

      from setuptools import Extension, setup

      CLASSIFIERS = """
      Development Status :: 5 - Production/Stable
      Intended Audience :: Developers
      License :: OSI Approved :: BSD License
      Programming Language :: C
      Programming Language :: Python :: 2
      Programming Language :: Python :: 2.7
      Programming Language :: Python :: 3
      Programming Language :: Python :: 3.5
      Programming Language :: Python :: 3.6
      Programming Language :: Python :: 3.7
      Programming Language :: Python :: 3.8
      """

      dconv_source_files = glob("./deps/double-conversion/double-conversion/*.cc")
      dconv_source_files.append("./lib/dconv_wrapper.cc")

      module1 = Extension(
          "ujson",
          sources=dconv_source_files
          + [
              "./python/ujson.c",
              "./python/objToJSON.c",
              "./python/JSONtoObj.c",
              "./lib/ultrajsonenc.c",
              "./lib/ultrajsondec.c",
          ],
          include_dirs=["./python", "./lib", "./deps/double-conversion/double-conversion"],
          extra_compile_args=["-D_GNU_SOURCE"],
          extra_link_args=["-lstdc++", "-lm"],
      )

      setup(
          name="ujson",
          version="${version}",
          description="Ultra fast JSON encoder and decoder for Python",
          long_description="",
          ext_modules=[module1],
          author="Jonas Tarnstrom",
          download_url="https://github.com/ultrajson/ultrajson",
          platforms=["any"],
          url="https://github.com/ultrajson/ultrajson",
          project_urls={"Source": "https://github.com/ultrajson/ultrajson"},
          setup_requires=["setuptools_scm"],
          python_requires=">=2.7, !=3.0.*, !=3.1.*, !=3.2.*, !=3.3.*, !=3.4.*",
          classifiers=[x for x in CLASSIFIERS.split("\n") if x],
      )
      EOF
    '';
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-vS3v/Jg4J1EOUUX7ZuTMD1d0gMYv4LSIITn499J66aM=";
    };
  };
  wsaccel = python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "wsaccel";
    version = "0.6.3";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-/bJ4Zrtrbnop5FIid4/5eTh4KgzpLv8H37IK+PuTAcQ=";
    };
  };
in
  python2Packages.buildPythonPackage rec {
    inherit doCheck;
    pname = "autobahntestsuite";
    version = "0.8.2";
    # Package duplicates found in closure
    # Twisted, Tubes and Traceback are slow and ujson
    buildInputs = [python2Packages.typing];
    propagatedBuildInputs = [autobahn unittest2 jinja2 werkzeug service-identity pyopenssl klein ujson wsaccel];
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-FUGANr8ouObwilJjnzf7ybueiXsB51gR0snXPHEem7A=";
    };
    meta = {
      description = "Autobahn WebSocket protocol testsuite";
      homepage = "https://github.com/crossbario/autobahn-testsuite";
      license = lib.licenses.asl20;
      platforms = lib.platforms.all;
      mainProgram = "wstest";
    };
  }
