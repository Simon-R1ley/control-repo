# plan/patch.pp
plan autopatch::patch (
  TargetSpec $targets,
) {
  $rootstatus = run_task('autopatch::checkingroot', $targets)

  if $rootstatus != 0 {
    fail_plan('Root partition is full')
  }

  $patchstatus = run_task('autopathc::patch', $targets)

  if $patchstatus!= 0 {
    fail_plan('patching failed')
  }
}
