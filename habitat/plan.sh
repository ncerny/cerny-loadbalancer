scaffold_policy_name="Policyfile"
pkg_name=$(awk -F "'" '/^name / {gsub(/'/',"",$2); print $2}' ../metadata.rb)
pkg_origin=ncerny
pkg_maintainer="$(awk -F "'" '/^maintainer / {print $2}' ../metadata.rb) <$(awk '/^maintainer_email / {print $2}' ../metadata.rb)>"
pkg_version=$(awk -F "'" '/^version / {print $2}' ../metadata.rb)
pkg_license=$(awk -F "'" '/^license / {print $2}' ../metadata.rb)
pkg_description=$(awk -F "'" '/^description / {print $2}' ../metadata.rb)
pkg_upstream_url="https://github.com/github/glb-director"
pkg_scaffolding="core/scaffolding-chef"
pkg_svc_user=("root")
