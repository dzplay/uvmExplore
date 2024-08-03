// rtl
$SIM_ROOT/common/avalon_module/src/burst_read_master.v

// agt
// +incdir+$SIM_ROOT/common/avalon_module/verif/avalon_agent
$SIM_ROOT/common/avalon_module/verif/avalon_agent/avalon_agent.f

// env
// +incdir+$SIM_ROOT/common/avalon_module/verif/env
$SIM_ROOT/common/avalon_module/verif/env/tb_env.f

// tests
+incdir+$SIM_ROOT/common/avalon_module/verif/tests
$SIM_ROOT/common/avalon_module/verif/tests/test_base.sv
// top
+incdir+$SIM_ROOT/common/avalon_module/verif
$SIM_ROOT/common/avalon_module/verif/tb_top.sv