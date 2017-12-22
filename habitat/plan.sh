pkg_name=hab_flask
pkg_origin=ariv3ra
pkg_version="0.1.3"
pkg_maintainer="Angel Rivera"
pkg_license=("Apache-2.0")
pkg_source="https://github.com/ariv3ra/hab_flask"
pkg_upstream_url="https://github.com/ariv3ra/hab_flask"
pkg_build_deps=(core/virtualenv)
pkg_deps=(core/coreutils core/python2)
pkg_exports=([http]=5000)
pkg_expose=(http)
pkg_svc_user="root"

# Need to opt-out of all of these steps, as we're copying in source code
do_download() {
    return 0
}
do_verify() {
    return 0
}
do_clean() {
    return 0
}

do_unpack() {
    # Because our habitat files liver under build/.
    PROJECT_ROOT="${PLAN_CONTEXT}/.."

    mkdir -p $pkg_prefix
    build_line "Copying project data to $pkg_prefix/"
    cp -r $PROJECT_ROOT/*.py $pkg_prefix/
    cp -r $PROJECT_ROOT/requirements.txt $pkg_prefix/
}

do_build() {
    return 0
}

do_install() {
    cd $pkg_prefix
    virtualenv venv
    source venv/bin/activate
    pip install -r requirements.txt
}