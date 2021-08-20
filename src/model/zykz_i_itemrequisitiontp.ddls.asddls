@AbapCatalog.sqlViewName: 'ZYKZIRIRQNTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Item Requisition'

@VDM.viewType : #TRANSACTIONAL

@ObjectModel:{createEnabled: true,
              updateEnabled: true,
              deleteEnabled: true,

              transactionalProcessingEnabled: true,
              draftEnabled: true,

              usageType.dataClass:  #TRANSACTIONAL,
              usageType.serviceQuality: #C,
              usageType.sizeCategory: #L,

              writeActivePersistence: 'ZYKZ_LX_RIRQSTN',
              writeDraftPersistence:  'ZYKZ_LX_RIRQSTND'}

define view ZYKZ_I_ItemRequisitionTP
  as select from ZYKZ_I_ItemRequisition

  association [1] to ZYKZ_I_RequestHeaderTP as _RequestHeaderTP on $projection.HeaderUUID = _RequestHeaderTP.UUID
  association [1] to ZYKZ_I_RequestItemTP   as _RequestItemTP   on $projection.ItemUUID = _RequestItemTP.UUID

{
  key UUID,
      ItemUUID,
      HeaderUUID,
      RequisitionName,

      @ObjectModel.association.type: [#TO_COMPOSITION_ROOT]
      _RequestHeaderTP,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT]
      _RequestItemTP

}
