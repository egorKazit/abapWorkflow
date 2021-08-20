@ClientDependent: false
@AccessControl.authorizationCheck: #PRIVILEGED_ONLY
@EndUserText.label: 'Generated: Flex Workflow CDS for scenario WS99900002'
define table function ZSWFM_99900002
with parameters wf_id:sww_wiid
returns {
  key WorkflowId : sww_wiid;
  _WF_INITIATOR : SWP_INITIA;
  _WF_PRIORITY : SWW_PRIO;
  _WF_VERSION : SWD_VERSIO;
  LASTAPPROVER : SWP_AAGENT;
  USERDECISIONFORMANUAL : SWP_CVALUE;

}
implemented by method ZCL_SWF_99900002=>read_meta;
