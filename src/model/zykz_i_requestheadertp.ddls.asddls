@AbapCatalog.sqlViewName: 'ZYKZIRHDRTP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Request Header'

@VDM.viewType : #TRANSACTIONAL

@ObjectModel:{createEnabled: true,
              updateEnabled: true,
              deleteEnabled: true,

              representativeKey: 'UUID',
              semanticKey: 'RequestID',

              compositionRoot: true,
              transactionalProcessingEnabled: true,
              draftEnabled: true,
 
              usageType.dataClass:  #TRANSACTIONAL,
              usageType.serviceQuality: #C,
              usageType.sizeCategory: #L,

              writeActivePersistence: 'ZYKZ_LX_REQUEST',
              writeDraftPersistence:  'ZYKZ_LX_REQUESTD'}

define view ZYKZ_I_RequestHeaderTP
  as select from ZYKZ_I_RequestHeader

  association [0..*] to ZYKZ_I_RequestItemTP      as _RequestItemTP      on $projection.UUID = _RequestItemTP.HeaderUUID
{
  key UUID,
      RequestID,
      RequestName,
      Description,
      RequestStatus,
      Priority,

      @ObjectModel.association.type: [#TO_COMPOSITION_CHILD]
      _RequestItemTP
}
