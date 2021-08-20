@AbapCatalog.sqlViewName: 'ZYKZIRITMTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Item'

@VDM.viewType : #TRANSACTIONAL

@ObjectModel:{createEnabled: true,
              updateEnabled: true,
              deleteEnabled: true,

              transactionalProcessingEnabled: true,
              draftEnabled: true,

              usageType.dataClass:  #TRANSACTIONAL,
              usageType.serviceQuality: #C,
              usageType.sizeCategory: #L,

              writeActivePersistence: 'ZYKZ_LX_REQITEM',
              writeDraftPersistence:  'ZYKZ_LX_REQITEMD'}

define view ZYKZ_I_RequestItemTP
  as select from ZYKZ_I_RequestItem
  association [1]    to ZYKZ_I_RequestHeaderTP   as _RequestHeaderTP     on $projection.HeaderUUID = _RequestHeaderTP.UUID
  association [0..*] to ZYKZ_I_ItemRequisitionTP as _ItemRequisitionTP on $projection.UUID = _ItemRequisitionTP.ItemUUID
{
  key UUID,
      HeaderUUID,
      ItemName,
      Description,
      RequisitionCount,

      @ObjectModel.association.type: [#TO_COMPOSITION_PARENT,#TO_COMPOSITION_ROOT]
      _RequestHeaderTP,

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _ItemRequisitionTP

}
